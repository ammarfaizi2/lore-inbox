Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTENXQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 19:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTENXQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 19:16:00 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:36493 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263129AbTENXP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 19:15:59 -0400
Date: Wed, 14 May 2003 19:24:55 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305141928_MC3-1-38F1-60EC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Siebenmann wrote:

> |   The people who used to require that still have lists of approved
> | operating systems.  Linux is not on that list.
> 
> To be blunt: and?
> Linux is not and never will be all things to all people. (Some of that
> can be seen in the ongoing discussions over, eg, LSM.)
>  There are many features that have far too small a target market to be
> of interest in mainline Unix.

  Large organizations like to standardize things wherever possible.

  Given an OS that is well suited for a fairly secure environment
that also runs widely-available office software, they will adopt it
for both uses, thus locking out other operating systems.

  Many of these decisions are made by Dumb White Guys sitting around
a boardroom table looking at feature lists, and pushed by even dumber
3-letter consulting firms whose technical representatives say things
like "Yes, we will be decrypting all SSL sessions at the firewall to
check for viruses."

  So I think Linux needs these 'fringe' features if it's going to
continue to expand its user base in the face of such stupidity.


