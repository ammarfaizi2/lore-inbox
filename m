Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268009AbTAIUqt>; Thu, 9 Jan 2003 15:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268010AbTAIUqs>; Thu, 9 Jan 2003 15:46:48 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:29410 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S268009AbTAIUqs>; Thu, 9 Jan 2003 15:46:48 -0500
Date: Thu, 9 Jan 2003 15:55:23 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: "Mother" == "computer-illiterate"
Message-ID: <20030109205523.GA1158@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <BEATLEQR7j1HaKtKufV000000ef@beatle.wrconsulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEATLEQR7j1HaKtKufV000000ef@beatle.wrconsulting.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 12:47:12PM -0800, Kaz Kylheku wrote:
> Illiterate idiots, that should be:
> 
>     strcpy("Mother", "computer-illiterate") == 0
> 
> Mind what list you're on.
> 
> :)
> 
Perhaps you meant
	strcmp("Mother", "computer-illiterate")
?

strcpy with two string literals won't compile.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker
  #cooker = moderated Mandrake Cooker

