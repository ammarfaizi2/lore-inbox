Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbTAGLhG>; Tue, 7 Jan 2003 06:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267044AbTAGLhG>; Tue, 7 Jan 2003 06:37:06 -0500
Received: from mail.zmailer.org ([62.240.94.4]:17811 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S266367AbTAGLhF>;
	Tue, 7 Jan 2003 06:37:05 -0500
Date: Tue, 7 Jan 2003 13:45:41 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Undelete files on ext3 ??
Message-ID: <20030107114541.GU5948@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0301071004550.30728-100000@dns.toxicfilms.tv> <200301071130.h07BURnq000165@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301071130.h07BURnq000165@darkstar.example.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 11:30:27AM +0000, John Bradford wrote:
> > > There is no simple way, no.
> > What about IDE Taskfile access, it's help says something like it's the
> > crown jewel of hard drive forensics.
> 
> What *is* IDE Taskfile access exactly?
> 
> I assumed it was a way of accessing a list of queued commands in the
> device that had not been processed yet.

  An alternate low-levelish protocol to communicate
  with IDE devices.  In the present "Subject:" scope,
  it is way below of what filesystems do.

  The  "ext2 undelete" tool might help, as filesystem
  layout of EXT3 is identical to that of EXT2.

> John.

/Matti Aarnio
