Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWD1P5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWD1P5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWD1P5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:57:12 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22192 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030448AbWD1P5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:57:11 -0400
Date: Fri, 28 Apr 2006 17:56:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: Martin Mares <mj@ucw.cz>, Davi Arnaut <davi.lkml@gmail.com>,
       Willy Tarreau <willy@w.ods.org>, Denis Vlasenko <vda@ilport.com.ua>,
       dtor_core@ameritech.net, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
In-Reply-To: <4451FCCC.4010006@argo.co.il>
Message-ID: <Pine.LNX.4.61.0604281755360.9011@yvahk01.tjqt.qr>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
 <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>
 <444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua>
 <20060427201531.GH13027@w.ods.org> <750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com>
 <4451E185.9030107@argo.co.il> <mj+md-20060428.105455.7620.atrey@ucw.cz>
 <4451FCCC.4010006@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The high level language allows you to concentrate on the algorithms which is
> where the performance comes from.
>
Do you consider e.g. Perl or Python highlevel?
If so: I doubt that's where performance can come from. Ever. (Unless you 
cheat by using XS.)


Jan Engelhardt
-- 
