Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132707AbRDCWGG>; Tue, 3 Apr 2001 18:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132708AbRDCWF5>; Tue, 3 Apr 2001 18:05:57 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:17417 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132707AbRDCWFn>; Tue, 3 Apr 2001 18:05:43 -0400
Message-Id: <200104032202.f33M1xs17898@aslan.scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: pochini@denise.shiny.it (Giuliano Pochini),
        nietzel@yahoo.com (Earle Nietzel), linux-kernel@vger.kernel.org
Subject: Re: Minor 2.4.3 Adaptec Driver Problems 
In-Reply-To: Your message of "Tue, 03 Apr 2001 22:50:44 BST."
             <E14kYhL-0000Ve-00@the-village.bc.nu> 
Date: Tue, 03 Apr 2001 16:01:59 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Volume labels dont help for all cases. Its a bug in the 6.1.5 adaptec driver
>which (to save Justin pointing it out) is fixed in 6.1.8

Actually, there is a component of this related to link order which is
fixed in the upcoming 6.1.9 driver release.  The 7895, channel B
primary issue, is fixed in 6..1.8.

--
Justin
