Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132399AbRDYU7H>; Wed, 25 Apr 2001 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132434AbRDYU66>; Wed, 25 Apr 2001 16:58:58 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:31403 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132399AbRDYU6x>; Wed, 25 Apr 2001 16:58:53 -0400
Date: Wed, 25 Apr 2001 15:58:51 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104252058.PAA37295@tomcat.admin.navo.hpc.mil>
To: markus.schaber@student.uni-ulm.de, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Single user linux
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Wed, 25 Apr 2001, Rick Hohensee wrote:
> 
> > imel96@trustix.co.id wrote:
> > > for those who didn't read that patch, i #define capable(),
> > > suser(), and fsuser() to 1. the implication is all users
> > > will have root capabilities.
> >
> > How is that not single user?
> 
> Every user still has it's own account, means profile etc.

Until some user removes all the other users....
Or reads the other users mail....
Or changes the other users configuration....

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
