Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318236AbSH1AeQ>; Tue, 27 Aug 2002 20:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSH1AeQ>; Tue, 27 Aug 2002 20:34:16 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:42407 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318236AbSH1AeP>; Tue, 27 Aug 2002 20:34:15 -0400
Date: Tue, 27 Aug 2002 20:43:04 -0400
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
Message-ID: <20020828004304.GA16704@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IDE merge is b0rken wrt partitioning.  Patchset that is supposed to fix
> that stuff is on ftp.math.psu.edu/pub/viro/IDE/* 

I was getting this on 2.5.32:
mount: wrong fs type, bad option, bad superblock on /dev/hda1,
       or too many mounted file systems

With Al's patchset, 2.5.32 is mounting my IDE filesystems okay.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

