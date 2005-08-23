Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVHWIgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVHWIgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 04:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVHWIgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 04:36:11 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:34507 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932068AbVHWIgL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 04:36:11 -0400
References: <11394.1124781401@kao2.melbourne.sgi.com>
            <200508190055.25747.dtor_core@ameritech.net>
            <20050823073258.GE743@frodo>
            <84144f02050823005573569fcb@mail.gmail.com>
            <20050823012839.649645c2.akpm@osdl.org>
In-Reply-To: <20050823012839.649645c2.akpm@osdl.org>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: Pekka Enberg <penberg@gmail.com>, nathans@sgi.com, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, greg@kroah.com, hch@infradead.org
Subject: Re: sysfs: write returns ENOMEM?
Date: Tue, 23 Aug 2005 11:36:09 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.430ADFF9.00003443@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> That's lame.  It'd be better to hunt down all the -ENOMEMs and fix them up.

So there's our verdict. Thanks, Andrew :-) 

       Pekka 
