Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291753AbSBNQQN>; Thu, 14 Feb 2002 11:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291754AbSBNQP6>; Thu, 14 Feb 2002 11:15:58 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:11649
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S291746AbSBNQOn>; Thu, 14 Feb 2002 11:14:43 -0500
Date: Thu, 14 Feb 2002 09:14:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Allan Sandfeld <linux@sneulv.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-rc1
Message-ID: <20020214161437.GA2004@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.21.0202131732330.20915-100000@freak.distro.conectiva> <E16b8HV-0001JS-00@Princess>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16b8HV-0001JS-00@Princess>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 11:53:41PM +0100, Allan Sandfeld wrote:
> On Wednesday 13 February 2002 20:33, Marcelo Tosatti wrote:
> > So here it goes.
> >
> > rc1:
> <snip>
> > - Merge some -ac bugfixes			(Alan Cox)
> 
> Here's a crazy idea. Why not branch off the new pre-tree when commiting a 
> rc-kernel? 

Because it would remove people from the pool of testers.  Part of the
goal of the -rc series seems to be to get as many people running a
kernel as possible to find potential bugs.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
