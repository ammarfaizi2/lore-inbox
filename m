Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285593AbSAILvg>; Wed, 9 Jan 2002 06:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285134AbSAILv0>; Wed, 9 Jan 2002 06:51:26 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:55562 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S285593AbSAILvP>; Wed, 9 Jan 2002 06:51:15 -0500
Date: Wed, 9 Jan 2002 12:51:13 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, dietlibc@fefe.de
Subject: Re: [ANNOUNCE] klibc 0.1 release
Message-ID: <20020109115113.GC5707@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>, dietlibc@fefe.de
In-Reply-To: <20020108014100.GD10145@kroah.com> <20020108020915.GA13168@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020108020915.GA13168@codeblau.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jan 2002, Felix von Leitner wrote:

> I understand that's OK for diet hotplug, so it's OK to take just enough
> code to make your project work.  The important question probably is
> whether diet hotplug will be part of the kernel distribution or not.
> If not, I don't think it makes much sense to not just reference the diet
> libc.  Maybe we can put the diet libc distribution on ftp.kernel.org to
> show the affinity better (and make it more widely mirrored).
> 
> But forking means you will have to watch our CVS and port stuff from
> here to there every now and then.

More importantly, the dietlibc compilation units are tiny, so even
linking against dietlibc itself is probably not much different in
outcome than a spinoff.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
