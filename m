Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTB0J5c>; Thu, 27 Feb 2003 04:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTB0J5c>; Thu, 27 Feb 2003 04:57:32 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:16272 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S262500AbTB0J5c>; Thu, 27 Feb 2003 04:57:32 -0500
Message-Id: <200302271007.h1RA7aGi008672@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] remove mod_inc_use_count from lec 
In-reply-to: Your message of "26 Feb 2003 20:29:15 PST."
             <1046320155.8085.2.camel@rth.ninka.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 27 Feb 2003 05:07:36 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1046320155.8085.2.camel@rth.ninka.net>,"David S. Miller" writes:
>Chas, if you don't CC: me I assume you don't want this patch
>applied yet.  Just making sure you understand this :)

that was the intent.  i dont know if i like the pointer to the
pointer to the owner.  i really dont like exporting a struct.
maybe this should be a pointer to a struct instead.
