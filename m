Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270806AbTHOTjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270808AbTHOTjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:39:47 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:3078 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S270806AbTHOTjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:39:14 -0400
Message-Id: <200308151945.h7FJj1IW003586@ccure.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: steven james <pyro@linuxlabs.com>
cc: Henrik Nordstrom <hno@marasystems.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] uml-patch-2.6.0-test1 
In-Reply-To: Your message of "Sun, 27 Jul 2003 15:26:30 EDT."
             <Pine.LNX.4.21.0307271522230.12132-100000@ucontrol.mobiledns.com> 
References: <Pine.LNX.4.21.0307271522230.12132-100000@ucontrol.mobiledns.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Aug 2003 15:45:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pyro@linuxlabs.com said:
> I got networking going (at least for the switch daemon) by commenting
> out  dev->hard_header = uml_net_hard_header; 

I also got rid of the other do-nothing procedures in that chunk of code.
The 2.6 UML will have a working network in the next release.

				Jeff

