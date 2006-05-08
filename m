Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWEHUNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWEHUNd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 16:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWEHUNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 16:13:33 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:27591 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751300AbWEHUNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 16:13:32 -0400
Date: Mon, 8 May 2006 22:13:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix console utf8 composing
In-Reply-To: <Pine.LNX.4.61.0604031048330.2220@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0605082211580.20743@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0604022005290.12603@yvahk01.tjqt.qr>
 <44308100.6080009@ums.usu.ru> <Pine.LNX.4.61.0604031048330.2220@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

>> Yes, please assume this line on all utf8 composing patches I submitted to LKML:
>> But this line already exists in http://lkml.org/lkml/2006/3/20/571 :)
>Must have missed it.
>

Your patch will not apply 100% cleanly to 2.6.17-rc3, and in fact it 
seems like it is not needed anymore (composing works without it again).
Can you confirm that?



Jan Engelhardt
-- 
