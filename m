Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWEBL3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWEBL3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWEBL3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:29:39 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:31135 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964776AbWEBL3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:29:38 -0400
Date: Tue, 2 May 2006 13:29:25 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Marcin Hlybin <marcin.hlybin@swmind.com>, linux-kernel@vger.kernel.org
Subject: Re: Open Discussion, kernel in production environment
In-Reply-To: <1146553275.32045.15.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0605021328400.17510@yvahk01.tjqt.qr>
References: <200605012357.48623.marcin.hlybin@swmind.com>
 <1146553275.32045.15.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I always configure and compile a kernel throwing out all unusable options and 
>> I never use modules in production environment (especially for the router). 
>> But my superior has got the other opinion - he claims that distribution 
>> kernel is quite good and in these days optimization has no sense because of 
>> powerful hadrware. 
>
>On the plus side you get the maintenance, building and integration done
>for you, including the security fixes. 
>
>There is a third "advantage" in using a distro kernel; there is less
>chance of a mistake in the sense of picking a config option that turns
>out to be really bad in hindsight. 
>
At best pick the distro kernel .src.rpm (or equivalent). If required, you 
can still roll your own _and_ have the security fixes etc.


Jan Engelhardt
-- 
