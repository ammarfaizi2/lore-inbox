Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbSJ0LYq>; Sun, 27 Oct 2002 06:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262366AbSJ0LYq>; Sun, 27 Oct 2002 06:24:46 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:55308 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262365AbSJ0LYq>;
	Sun, 27 Oct 2002 06:24:46 -0500
Date: Sun, 27 Oct 2002 12:30:56 +0100
From: Willy Tarreau <willy@w.ods.org>
To: John W Fort <johnf@whitsunday.net.au>
Cc: patmans@us.ibm.com, andmike@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: SCSI host changes, multi-path crap
Message-ID: <20021027113056.GB789@alpha.home.local>
References: <jqumrucl0cu7i9vtr186d05difvcipdk0l@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jqumrucl0cu7i9vtr186d05difvcipdk0l@4ax.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 03:39:59PM +1000, John W Fort wrote:
> HEY! andmike and patmans of @us.ibm.com YOU FUCKED UP.
> 
> For two weeks in a row you have submitted code that deliberately 
> breaks scsi drivers.

hmmm you're talking about a development kernel, don't you ? So why are you
shouting at people who clean up the drivers that one day you'll be happy to use
on production machines ? you participation should have been :

"Hey! andmike and patmans, I inform you that your last changes broke these
drivers: <list of broken drivers>. Here is the patch to fix them : <patch>"

I really don't understand how you may reproach problems to people working on a
development kernel. This is work in progress. Nothing stable, nothing guaranted
to even compile. Perhaps you're too ignorant to understand that and bindly use
every latest kernel on all your production servers, believing it will fix any
unknown bug ?

Or perhaps you were drunk and will apologise today ?

Willy

