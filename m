Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314223AbSDVP2n>; Mon, 22 Apr 2002 11:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314225AbSDVP2m>; Mon, 22 Apr 2002 11:28:42 -0400
Received: from dsl-213-023-039-131.arcor-ip.net ([213.23.39.131]:9628 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314223AbSDVP2m>;
	Mon, 22 Apr 2002 11:28:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Dan Yocum <yocum@fnal.gov>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
Date: Sun, 21 Apr 2002 17:29:23 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3CC427F4.12C40426@fnal.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16zJHH-0001GJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 April 2002 17:10, Dan Yocum wrote:
> I know it's been discussed to death, but I am making a formal request to you
> to include XFS in the main kernel.  We (The Sloan Digital Sky Survey) and
> many, many other groups here at Fermilab would be very happy to have this in
> the main tree.  

The issue is how XFS's private versions of what would normally be generic vfs
facilities fit with the rest of the kernel.  Want to help in the analysis?
Feel free to jump in.

> Currently the SDSS has ~20TB of XFS filesystems, most of which is in our 14
> fileservers and database machines.  The D-Zero experiment has ~140 desktops
> running XFS and several XFS fileservers.  We've been using it since it was
> released, and have found it to be very reliable.
> 
> I'll even attempt to bribe you with homebrew beer - would that help??  ;-)

Programmer cycles would help.  Oh, you can offer $$$ to certain kernel hackers
if you want it to go faster.  Not to engage in advocacy of course, but to do
the necessary analysis.

-- 
Daniel
