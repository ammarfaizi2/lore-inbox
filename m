Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314454AbSDWWpr>; Tue, 23 Apr 2002 18:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314474AbSDWWpq>; Tue, 23 Apr 2002 18:45:46 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37387 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314454AbSDWWpo>; Tue, 23 Apr 2002 18:45:44 -0400
Date: Tue, 23 Apr 2002 18:42:47 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Kent Borg <kentborg@borg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Versioning File Systems?
In-Reply-To: <20020418110558.A16135@borg.org>
Message-ID: <Pine.LNX.3.96.1020423183559.31248D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002, Kent Borg wrote:

> I just read an article mentioned on Slashdot,
> <http://www.sigmaxi.org/amsci/Issues/Comsci02/Compsci2002-05.html>.
> 
> It is a fascinating short summary of the history of hard disks (they
> still use the same fundamental design as the very first one) and an
> update on current technology (disks are no longer aluminum).  It also
> looks at today's 120 gigabyte disk and muses over the question of how
> we might ever put an imagined 120 terabyte disk to use.  And the got
> me thinking various thoughts, one turns into a question for this list:
> It there any work going on to make a versioning file system?
> 
> I remember in VMS that I could accumulate "myfile.txt;1",
> "myfilw.txt;2", etc., until the local admin got pissed at me for using
> up all the disk space with my several megabytes of redundant files.

  I seem to remember that some CD filesystem does that, and you can see
the versions with Linux if you mount with the right options.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

