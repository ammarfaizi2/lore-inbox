Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbSKYCUh>; Sun, 24 Nov 2002 21:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262366AbSKYCUh>; Sun, 24 Nov 2002 21:20:37 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:3211 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262363AbSKYCUg>; Sun, 24 Nov 2002 21:20:36 -0500
Date: Sun, 24 Nov 2002 21:27:18 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.49 kernel panic - cannot load root fs from 3:0a
Message-ID: <20021125022718.GA1742@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021124215113.GC1597@Master.Wizards> <20021125003426.GE21852@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021125003426.GE21852@louise.pinerecords.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 01:34:26AM +0100, Tomas Szepe wrote:
> > I get the message referred to in the subject when trying to boot
> > 2.5.49.
> > My entire drive is reiserfs. kernel compiled with reiserfs.
> > Does resierfs (v4) not work with older reiserfs?
> 
> 'reiser4' is an entirely new fs.  you have to compile in 'reiserfs'
> to be able to mount v3.[56] volumes.
> 

There's only one reiserfs option in the GUI config - REISERFS_FS.
That's set to Y.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

