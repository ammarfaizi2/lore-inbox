Return-Path: <linux-kernel-owner+w=401wt.eu-S1752444AbWLXSHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbWLXSHV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 13:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWLXSHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 13:07:20 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:33912 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444AbWLXSHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 13:07:19 -0500
Message-Id: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl>
To: Jeff Garzik <jeff@garzik.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated Kernel Hacker's guide to git 
In-Reply-To: Message from Jeff Garzik <jeff@garzik.org> 
   of "Wed, 20 Dec 2006 22:04:17 CDT." <4589F9B1.2020405@garzik.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Sun, 24 Dec 2006 15:07:04 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:01:51 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 24 Dec 2006 15:07:08 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
> I refreshed my git intro/cookbook for kernel hackers, at
> http://linux.yyz.us/git-howto.html

Looks nice, starting to look it over.

Notes:

Getting started:

  There are RPM packages available (I think they are for latest Fedora; in
  case of doubt get the latest SRPM and build yourself, sometimes the
  distros lag /way/ behind). There are also Debian packages there, dunno
  about those.

Basic tasks:

  'git pull' should be enough, no need to give the URL each time.
  It is useful to tell people how to get "nonofficial" branches (via URL +
  branches) too.
  

Miscellaneous debris:

  'git pull' has gotten tags each time for me?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
