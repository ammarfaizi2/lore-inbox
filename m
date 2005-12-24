Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVLXU7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVLXU7M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 15:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVLXU7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 15:59:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41438 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750718AbVLXU7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 15:59:11 -0500
Date: Sat, 24 Dec 2005 21:58:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Mukund JB." <mukundjb@esntechnologies.co.in>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH:  day of week (RE: Kernel interrupts disable at user level
 - RIGHT/ WRONG - Help)
In-Reply-To: <1135123252.25010.33.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0512242157530.29877@yvahk01.tjqt.qr>
References: <3AEC1E10243A314391FE9C01CD65429B2232A4@mail.esn.co.in>
 <1135123252.25010.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>What do people thing about this ?

Well why not. I doubt any program relied on the - anyway broken - tm_wday 
field so far.


Jan Engelhardt
-- 
