Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUHVF6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUHVF6m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHVF6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:58:35 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44198 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266223AbUHVF6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:58:24 -0400
Subject: Re: Linux Incompatibility List
From: Lee Revell <rlrevell@joe-job.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jonathan Bastien-Filiatrault <joe@dastyle.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Wakko Warner <wakko@animx.eu.org>,
       "David N. Welton" <davidw@dedasys.com>,
       James Courtier-Dutton <James@superbug.demon.co.uk>
In-Reply-To: <DF012E80-F3F1-11D8-A7C9-000393ACC76E@mac.com>
References: <87r7q0th2n.fsf@dedasys.com>
	 <20040821201632.GA7622@digitasaru.net> <20040821202058.GA9218@animx.eu.org>
	 <1093120274.854.145.camel@krustophenia.net> <41282F4C.9060305@dastyle.net>
	 <4127FD5A.90605@superbug.demon.co.uk> <41283EDA.6080501@dastyle.net>
	 <DF012E80-F3F1-11D8-A7C9-000393ACC76E@mac.com>
Content-Type: text/plain
Message-Id: <1093154304.817.40.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 Aug 2004 01:58:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-22 at 00:15, Kyle Moffett wrote:
> > Good idea, we should have something like two lists one for "chips" and 
> > one for "containers of chips" aka whole systems. That way it could be 
> > cross-referenced in a database-like way with a nice gtk frontend. The 
> > project probably ressemble the pci-ids project. That would pave the 
> > way for a free(as in speech) hardware purchasing guide.
> 
> A well designed guide could go a long way toward convincing companies 
> to release specs.  When a well known hardware website has user 
> testimonials that the drivers suck, the tech support are unhelpful, and 
> the company just doesn't get it, said company will probably tend to 
> listen.
> 

Takashi Iwai's 'Writing an ALSA driver' (google for it) is IMHO the
exemplar in this area.  It is written at *exactly* the right level.
Several major vendors have come on alsa-devel and posted to the effect
that they followed this guide and have their driver 99% working, they
just need help with this or that, someone answers a question or two, and
bang, one more Linux-supported device.  There should be a document of
this quality covering every major category of driver.

Lee

