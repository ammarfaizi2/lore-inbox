Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWC1ORX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWC1ORX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWC1ORX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:17:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:28563 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932256AbWC1ORW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:17:22 -0500
Date: Tue, 28 Mar 2006 16:17:05 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Douglas Gilbert <dougg@torque.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       Bodo Eggert <7eggert@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
In-Reply-To: <4428E7CB.6030407@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.61.0603281616230.27529@yvahk01.tjqt.qr>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz> 
 <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org>  <4427FEC9.4010803@torque.net>
  <Pine.LNX.4.64.0603270854570.15714@g5.osdl.org>  <20060327172530.GH3486@parisc-linux.org>
  <Pine.LNX.4.64.0603270936290.15714@g5.osdl.org> <1143489287.4970.76.camel@localhost.localdomain>
 <44285929.4020806@torque.net> <4428E7CB.6030407@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[host/ channel/ target/ LU enumeration...]
>>> is still a very visible reality if you work in a data centre or with
>>> server kit, or if you have tape arrays or multi-CD towers. The LUN or
>>> device number in particular are generally the number emblazoned on each
>>> slot in the unit
>...
>> USB multi-card readers seem to like the concept of LUNs as well.
>
>Sure. The h:c:i:l tuple does not provide the LUN though, only an ersatz.

[For the list:]

..., only a replacement.


Jan Engelhardt
-- 
