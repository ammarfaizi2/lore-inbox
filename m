Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVCZRn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVCZRn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 12:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCZRn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 12:43:27 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22922 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261186AbVCZRnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 12:43:18 -0500
Date: Sat, 26 Mar 2005 18:43:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Seydl <mingy@hlw.co.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.6.11 Kernel Hangs after hlt checking
In-Reply-To: <1111851854.9137.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0503261842390.9796@yvahk01.tjqt.qr>
References: <1111851854.9137.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>actually i've exprienced this happening with old systems but not with a
>new one. 

Well, only with older i386's...

>haven't started debugging yet maybe someone has experinced the same
>issue. 

Anyway, you could try the "nohlt" bootoption, as well as sysrq+t when it 
hangs.



Jan Engelhardt
-- 
No TOFU for me, please.
