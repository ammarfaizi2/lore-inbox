Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbRKSFHG>; Mon, 19 Nov 2001 00:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281804AbRKSFG4>; Mon, 19 Nov 2001 00:06:56 -0500
Received: from [208.48.139.185] ([208.48.139.185]:64996 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S280126AbRKSFGt>; Mon, 19 Nov 2001 00:06:49 -0500
Date: Sun, 18 Nov 2001 21:06:42 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Need Very High Speed/Large Storage Space Linux Box
Message-ID: <20011118210642.A26128@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011118204729.A5067@infomine.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011118204729.A5067@infomine.ucr.edu>; from ruschein@infomine.ucr.edu on Sun, Nov 18, 2001 at 08:47:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2001 at 08:47:29PM -0800, Johannes Ruscheinski wrote:
> 
> My research group is looking to implement a Linux 2.4.15pre6+ based system
> with the following requirement:
> 2GB RAM, 800GB-1TB raid disk storage (ext3?).  We need good disk throughput and
> have around $10,000 to spend.  Dual Athlons would be great but if there is no
> highly reliable solution with Athlons we might also consider P4's.  We would
> like to be able to upgrade our system in the future and CPU speed is not nearly
> as important to as as disk throughput.  We are working on a publicly funded Web
> search engine project that will be released under the GPL sometime next year
> (we are about 70% into this and have very exciting and promising results, i.e.
> we'll probably get quite a bit more money).  We are also considering spending
> more money and doubling the disk space in order to mirror the custom database 
> that we want to store on this monster.  Unfortunately we have to make a very
> quick decision.  Stability is very important on this project.  I am one of the
> developers on the project and may also do the system administration on it as
> well.
> Please help if you have any experience with a beast of a similar nature.

SDSC has done some work on such a beast, it only cost them about $5000 a few
months ago.

You can see the Slashdot article here:
http://slashdot.org/article.pl?sid=01/07/19/1554216&mode=thread

And the SDSC site here:
http://staff.sdsc.edu/its/terafile/

-Dave
