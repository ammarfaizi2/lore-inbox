Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbTBEWXV>; Wed, 5 Feb 2003 17:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTBEWXU>; Wed, 5 Feb 2003 17:23:20 -0500
Received: from vena.lwn.net ([206.168.112.25]:62894 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S265066AbTBEWXU>;
	Wed, 5 Feb 2003 17:23:20 -0500
Message-ID: <20030205223256.17078.qmail@eklektix.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about creating char device in 2.4 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 05 Feb 2003 17:03:30 EST."
             <3E418A32.2010308@nortelnetworks.com> 
Date: Wed, 05 Feb 2003 15:32:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How would you go about hooking in to the 2.4 char device code to do 
> something equivalent?

Linux Device Drivers has a great deal of discussion on portability between
2.2 and 2.4; it also has example code which could be easily adapted to
create your "finite capacity bit bucket" device.  It's available online at
http://www.xml.com/ldd/chapter/book/index.html, but, of course, you'll want
to go and buy at least three copies for your desk...

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
