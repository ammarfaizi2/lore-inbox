Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318692AbSG0DsR>; Fri, 26 Jul 2002 23:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318693AbSG0DsR>; Fri, 26 Jul 2002 23:48:17 -0400
Received: from member.michigannet.com ([207.158.188.18]:50192 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S318692AbSG0DsR>; Fri, 26 Jul 2002 23:48:17 -0400
Date: Fri, 26 Jul 2002 23:50:42 -0400
From: Paul <set@pobox.com>
To: Matt Simonsen <matt@careercast.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to mount "multimedia" audio cdroms
Message-ID: <20020727035042.GI27089@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Matt Simonsen <matt@careercast.com>, linux-kernel@vger.kernel.org
References: <1027708015.3260.17.camel@mattlaptop.careercast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027708015.3260.17.camel@mattlaptop.careercast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Simonsen <matt@careercast.com>, on Fri Jul 26, 2002 [11:26:55 AM] said:
> Is there a way to mount multimedia audio cds under Linux so that instead
> of the .inf file and video you can listen to the audio tracks?
> 
> Thanks
> Matt
> 
> 
	Hi;

	I dont know if this will do what you want, or no. I also
dont know how active it is...

http://www.elis.rug.ac.be/~ronsse/cdfs/

Paul
set@pobox.com

---
CDfs is a file system for Linux systems that `exports' all tracks
and boot images on a CD as normal files. These files can then be
mounted (e.g. for ISO and boot images), copied, played (audio and
VideoCD tracks)... The primary goal for developing this file
system was to `unlock' information
in old ISO images. For instance, if you have a multisession CD
with two ISO images that both contain the file 'a', you only see
the file 'a' in the second session if you use the iso9660 file
system: 
---
