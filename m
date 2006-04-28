Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWD1Pvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWD1Pvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWD1Pvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:51:45 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:50102 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030445AbWD1Pvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:51:45 -0400
Date: Fri, 28 Apr 2006 17:51:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: Denis Vlasenko <vda@ilport.com.ua>, Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
In-Reply-To: <4450D4E9.4050606@argo.co.il>
Message-ID: <Pine.LNX.4.61.0604281748470.9011@yvahk01.tjqt.qr>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com>
 <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44507BB9.7070603@argo.co.il>
 <200604271655.48757.vda@ilport.com.ua> <4450D4E9.4050606@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> It still can't typecheck void pointers. With C++ they're very rare.
>
Using C++ just because one can't verify that all type conversions in a C 
program from/to void* are as they are supposed to be is... well, think of 
something.


Jan Engelhardt
-- 
