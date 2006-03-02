Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWCBVud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWCBVud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWCBVud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:50:33 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:8683 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932588AbWCBVuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:50:32 -0500
Date: Thu, 2 Mar 2006 22:50:30 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Gerard Snitselaar <snits@snitselaar.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about inline assembly for BUG()
In-Reply-To: <19805.198.115.32.5.1141330790.squirrel@cantor.snitselaar.org>
Message-ID: <Pine.LNX.4.61.0603022250010.13101@yvahk01.tjqt.qr>
References: <19805.198.115.32.5.1141330790.squirrel@cantor.snitselaar.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>For the following asm will anything show up in the actual
>code besides the ud2 opcode (0x0f0b) ? Is there any good references
>for inline assembly besides "Brennan's Guide to Inline Assembly" ?
>Thanks
>
What else than an asm book and the gcc info 'handbook' 
(/usr/share/info/...) do you need?


Jan Engelhardt
-- 
