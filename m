Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132725AbRC2MME>; Thu, 29 Mar 2001 07:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132724AbRC2MLz>; Thu, 29 Mar 2001 07:11:55 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:26365
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S132723AbRC2MLs>; Thu, 29 Mar 2001 07:11:48 -0500
Message-ID: <3AC32666.9EF161@math.ethz.ch>
Date: Thu, 29 Mar 2001 14:11:18 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@debian.org
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
CC: linux-kernel@vger.kernel.org, "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Plans for 2.5
In-Reply-To: <fa.ngc0npv.1dmkhh4@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hen, Shmulik" wrote:
> 
> Just some general questions:
> 
> 1) Is there anywhere a list that describes what is intended to be in 2.5.x ?

General/Big changes are discussed in:
http://lwn.net/2001/0329/a/kernel-summit-agenda.php3

> 2) Are there any early releases of 2.5.x ?
> 3) Are the things for 2.5.x being discussed on another mailing list ?

kbuild list discusses about:

new configuration language (an unified language: now there are
three
implementation: 2 shell like and one different, so it fail
with most
of changes).

new makefiles. Actual makefile will fail with dependencies and
modules.

> 4) What is the time frame of releasing 2.5.x-final (or 2.6.x) ?
> 

> Specifically, I'm more interested in the network driver aspect.
> 1) Are there any intended changes to the networking layer ?
> 2) I over heard something about making the driver reentrant - any news ?
> 3) What about support for IPv6 ? (I noticed it was marked as experimental
> until now)
 


	giacomo
