Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWFTV66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWFTV66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWFTV66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:58:58 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:56979 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751176AbWFTV66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:58:58 -0400
Date: Tue, 20 Jun 2006 23:58:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Edgar Hucek <hostmaster@ed-soft.at>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines
In-Reply-To: <20060620101605.0240a685.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0606202357330.17281@yvahk01.tjqt.qr>
References: <4497F85B.7010409@ed-soft.at> <20060620101605.0240a685.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Darn, I was going to comment on the patch, but the attachment
>isn't quoted... :(
>
>
>1.  if you modify this patch, change
>+	if(!efi_enabled) {
>to
>	if (!efi_enabled) {
>to be compatible with Linux coding style.
>
Care to name the section this is listed in? It is used all over the place 
in examples in the CodingStyle document, but I could not find an 
explanation which explicitly says "space after if".


Jan Engelhardt
-- 
