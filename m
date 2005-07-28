Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVG1N4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVG1N4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVG1NyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:54:11 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:16081 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261447AbVG1Nwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:52:34 -0400
Date: Thu, 28 Jul 2005 09:52:34 -0400
To: gabri <metadistros@yahoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Helpme WitCh Cpu Scaling. Hi People
Message-ID: <20050728135234.GB31019@csclub.uwaterloo.ca>
References: <00ca01c592f2$da9eac60$0801a8c0@SEBAS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ca01c592f2$da9eac60$0801a8c0@SEBAS>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 11:33:36PM +0200, gabri wrote:
> It is the first mail that I write. I call gabri and I am 18 years old. I am
> Spanish. I want to comment that me program does not work ningun to regulate
> the Mhz of the processor. " Cpufreq, cpuydn, powernow ". I do not manage to
> load ningun module from the kernel inside cpuscalig in that it(he,she)
> fences with an amd mobile sempron.
> The modules of athlon do not go.
> Do they work to give support to the mobile sempron in the future versions of
> the kernel?
> what can I do ?

Is this your message?
08:44 < gabri> Jul 28 16:25:26 debian kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
08:45 < gabri> Jul 28 16:25:26 debian kernel: powernow-k8: BIOS error: maxvid exceeded with pstate 0

You should probably also list the kernel version(s) (uname -a) and cpuinfo
(cat /proc/cpuinfo) just to have some more info to go on.

I don't actually know anything about the cpu frequency scaling myself,
since I just leave my systems running full speed all the time (I use
desktop machines, not laptops).

Len Sorensen
