Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132551AbRDAUie>; Sun, 1 Apr 2001 16:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132559AbRDAUiY>; Sun, 1 Apr 2001 16:38:24 -0400
Received: from pc57-cam4.cable.ntl.com ([62.253.135.57]:44674 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S132551AbRDAUiM>; Sun, 1 Apr 2001 16:38:12 -0400
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: unistd.h and 'extern's and 'syscall' "standard(?)" 
In-Reply-To: Message from LA Walsh <law@sgi.com> 
   of "Sun, 01 Apr 2001 13:23:00 PDT." <3AC78E24.98DEA986@sgi.com> 
In-Reply-To: <3AC75DBF.31594195@sgi.com> <jelmpktors.fsf@hawking.suse.de>  <3AC78E24.98DEA986@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 Apr 2001 21:38:24 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14jocC-0008Jg-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>of action to take.  Seeing as you work for suse, would you know
>where this 'syscall(3)' interface should be documented?  Is it
>supposed to be present in all distro's?  

It's documented in the glibc manual.  Yes, it should be present in all glibc 
based distributions.

p.


