Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbTBLPdw>; Wed, 12 Feb 2003 10:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBLPdv>; Wed, 12 Feb 2003 10:33:51 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:46799 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S267255AbTBLPdm>;
	Wed, 12 Feb 2003 10:33:42 -0500
Message-Id: <200302121537.KAA29967@moss-gators.epoch.ncsc.mil>
Date: Wed, 12 Feb 2003 10:37:08 -0500 (EST)
From: Pete Loscocco <pal@epoch.ncsc.mil>
Reply-To: Pete Loscocco <pal@epoch.ncsc.mil>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
To: hch@infradead.org, alan@lxorguk.ukuu.org.uk
Cc: sds@epoch.ncsc.mil, greg@kroah.com, torvalds@transmeta.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: wWC6AeWJoC0Iy7RE1CvpyA==
X-Mailer: dtmail 1.2.1 CDE Version 1.2.1 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2003-02-06 at 15:18, Christoph Hellwig wrote:
> > Life would be a lot simpler if you got the core flask engine in a 
mergeable
> > shapre earlier and we could have merged the hooks for actually using it
> > incrementally during 2.5, discussing the pros and contras for each hook
> 
> I'm not sure we can until the flask engine patent problems with secure
> computing are completely resolved and understood. 

Despite recent speculation concerning patents, we remain confident that
we had the necessary rights to release SELinux in the manner and under
the conditions in which we did and that SELinux may be used, copied,
distributed, and modified in accordance with the terms and conditions of
the GPL.

--
Peter Loscocco
SELinux Project Leader
National Security Agency

