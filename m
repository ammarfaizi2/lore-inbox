Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbTAKH7c>; Sat, 11 Jan 2003 02:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbTAKH7c>; Sat, 11 Jan 2003 02:59:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:9491 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267156AbTAKH7b>;
	Sat, 11 Jan 2003 02:59:31 -0500
Date: Sat, 11 Jan 2003 09:08:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Cherry <cherry@osdl.org>,
       Guillaume Boissiere <boissiere@nl.linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STABILITY] Compile / STP metrics for 2.5.56
Message-ID: <20030111080814.GA1240@mars.ravnborg.org>
Mail-Followup-To: John Cherry <cherry@osdl.org>,
	Guillaume Boissiere <boissiere@nl.linux.org>,
	linux-kernel@vger.kernel.org
References: <1042246990.32624.30.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042246990.32624.30.camel@cherrytest.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 05:03:11PM -0800, John Cherry wrote:
> Compile statistics have been for kernel releases from 2.5.46 to 2.5.56
> at: www.osdl.org/archive/cherry/stability
> 
> Not much change in the warnings and errors between 2.5.55 and 2.5.56. 
> However, from 2.5.54 onward, there was a significant increase in both
> warnings and errors (see web site).
Introduction of deprecated warnings counts for most of the added warnings...

I like this kind summary, which is good to take the temperatue on 
the full kernel build.
Small nit-pick on the pages. Could you plave the most relevant
figures first. That is add new kernels on the top of the table.
It does not matter now, but after 30 more kernels is matters.

[Btw. nice to see that someone actually uses KBUILD_VERBOSE=0]

Guillaume - maybe a link from your status page?

	Sam
