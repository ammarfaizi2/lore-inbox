Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbTAEOPe>; Sun, 5 Jan 2003 09:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbTAEOPe>; Sun, 5 Jan 2003 09:15:34 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:5562 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S264799AbTAEOPd>; Sun, 5 Jan 2003 09:15:33 -0500
Date: Sun, 5 Jan 2003 09:23:59 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: P4 Xeon operational temperature range
Message-ID: <20030105142359.GB1535@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3E18379B.30206@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E18379B.30206@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 01:48:11PM +0000, Andrew Walrond wrote:
> Does anybody know off the top of their head the max tempature at which I 
> can expect a P4 Xeon to operate ?
> 

>From the spec sheets at Intel it looks like the safe range varies a little
between 75 and 78 C depending on the specific Xeon in question.
For example
	http://www.intel.com/design/xeon/datashts/290740.htm
page 89 lists ranges of 75-78 depending on core freq.

I only found one chip that went above 78C (81C) but didn't delve into 
which it was.

Intel website has crappy navigation, but at least the info is there. :)

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker
  #cooker = moderated Mandrake Cooker

