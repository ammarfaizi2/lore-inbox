Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283995AbRLAHyo>; Sat, 1 Dec 2001 02:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283994AbRLAHyZ>; Sat, 1 Dec 2001 02:54:25 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42996
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283993AbRLAHyU>; Sat, 1 Dec 2001 02:54:20 -0500
Date: Fri, 30 Nov 2001 23:54:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Erik Elmore <lk@bigsexymo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT3 - freeze ups during disk writes
Message-ID: <20011130235414.E489@mikef-linux.matchmail.com>
Mail-Followup-To: Erik Elmore <lk@bigsexymo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112010044020.1024-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112010044020.1024-100000@localhost.localdomain>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 12:47:19AM -0600, Erik Elmore wrote:
> Ever since I started using ext3fs, whenever there is a disk write, the 
> kernel sucks up all of the CPU thereby preempting everything and causing 
> the PC to freeze momentarily.  Could this possibly be caused by the 
> journaling code in ext3?
> 

You really need to give kernel version, gcc version and what things were
happening at the time.

I can think of five different things that this general description has
brought up.

mf
