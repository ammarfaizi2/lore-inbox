Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVGTJV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVGTJV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 05:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVGTJV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 05:21:56 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:61312 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261473AbVGTJVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 05:21:55 -0400
Date: Wed, 20 Jul 2005 11:21:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ivan Yosifov <ivan@yosifov.net>
cc: Kerin Millar <kerframil@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Noob question. Why is the for-pentium4 kernel built with
 -march=i686 ?
In-Reply-To: <1121847799.31603.5.camel@home.yosifov.net>
Message-ID: <Pine.LNX.4.61.0507201120120.22899@yvahk01.tjqt.qr>
References: <1121792852.11857.6.camel@home.yosifov.net> 
 <Pine.LNX.4.61.0507191950020.89@yvahk01.tjqt.qr>  <1121798151.15700.9.camel@home.yosifov.net>
  <pan.2005.07.20.08.03.25.15476@gmail.com> <1121847799.31603.5.camel@home.yosifov.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> https://www.redhat.com/archives/fedora-devel-list/2005-January/msg00742.html
>
>Interesting. 

This may seem reasonable for a Linux distribution, but less for those who 
compile kernelballs just for themselves.
