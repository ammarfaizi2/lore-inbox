Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262350AbRERPqd>; Fri, 18 May 2001 11:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbRERPqX>; Fri, 18 May 2001 11:46:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24077 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262350AbRERPqM>; Fri, 18 May 2001 11:46:12 -0400
Subject: Re: CML2 design philosophy heads-up
To: linux-kernel@discworld.dyndns.org (Charles Cazabon)
Date: Fri, 18 May 2001 16:42:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010518093414.A21164@qcc.sk.ca> from "Charles Cazabon" at May 18, 2001 09:34:14 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150mOt-0007G1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Simplifying the configuration interface so that "anyone" can use it seems like
> a waste of effort.  If there's an interested novice out there who wants to
> learn how to configure a kernel, they'll be sufficiently interested to invest
> an hour or two in learning how the whole process works.  Make it as simple as
> it needs to be, and no simpler.

Having a simple interface is good. Being guided by probable correct choices 
helps many people, but it needs to support a simple interface as well as a real
one if the two conflict in design goals
