Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291560AbSBAF4U>; Fri, 1 Feb 2002 00:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291561AbSBAF4B>; Fri, 1 Feb 2002 00:56:01 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:4622 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S291560AbSBAFzu>;
	Fri, 1 Feb 2002 00:55:50 -0500
Date: Fri, 1 Feb 2002 08:55:45 +0300
From: Oleg Drokin <green@namesys.com>
To: Martin Bahlinger <ry42@rz.uni-karlsruhe.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020201085545.A1034@namesys.com>
In-Reply-To: <1012499057.704.0.camel@hek411> <Pine.LNX.4.31.0201312133490.652-100000@hek411.hek.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0201312133490.652-100000@hek411.hek.uni-karlsruhe.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jan 31, 2002 at 09:44:32PM +0100, Martin Bahlinger wrote:
> On 31 Jan 2002, Martin Bahlinger wrote:
> > After applying those patches to 2.5.3 I still got an Oops after a
> > PAP-14030 message. I will try to catch the Oops (have never done this
> > before, may take some time) and feed it to ksymoops.
> I actually had PAP-5760. And after applying the patches it was the
> PAP-14030. During all the tests today my reiserfs got currupted. A

You are the only who reporting these errors for now.
Can you reboot into vanilla 2.5.3 and capture PAP-5760 oops
and all reiserfs-specific output around it? Thank you.

> reiserfsck ran into a segfault when checking the semantic tree. And this

This means you need updated reiserfsprogs.

Bye,
    Oleg
