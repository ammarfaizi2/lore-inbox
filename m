Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbTCLTV3>; Wed, 12 Mar 2003 14:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbTCLTV2>; Wed, 12 Mar 2003 14:21:28 -0500
Received: from mail.eskimo.com ([204.122.16.4]:65296 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S261886AbTCLTUy>;
	Wed, 12 Mar 2003 14:20:54 -0500
Date: Wed, 12 Mar 2003 11:25:39 -0800
To: James Stevenson <james@stev.org>
Cc: David Shirley <dave@cs.curtin.edu.au>,
       "M. Soltysiak" <msoltysiak@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux BUG: Memory Leak
Message-ID: <20030312192539.GA2285@eskimo.com>
References: <F44Bre5NuYqYYDleNlx00025ecc@hotmail.com> <041f01c2e86a$872520d0$64070786@synack> <1047494337.2064.1.camel@god.stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047494337.2064.1.camel@god.stev.org>
User-Agent: Mutt/1.5.3i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 06:38:57PM +0000, James Stevenson wrote:
> On Wed, 2003-03-12 at 07:19, David Shirley wrote:
> > Err for starters you should include kernel version and OS versions etc.
> > 
> > Also how do you expect any computer to work once it has run out of
> > memory? Do you have swap partition? I suspect not, or a small one in
> > any case!
> > 
> > Some of the applications you mention are notorios for memory leaks
> > themselves. ie UT!
> 
> iirc UT will only run with openGL under X last time i looked about 3
> months ago the only card that was fully supporting this was the nvidia
> Geforce series with closed source drivers.
> 
> Tainted kernel :/

Reportedly, the latest releastes of UT2k3 no longer require S3TC to run,
and will thus work with some open source drivers.

-J
