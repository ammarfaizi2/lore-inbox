Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132047AbRBQWjL>; Sat, 17 Feb 2001 17:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132059AbRBQWjB>; Sat, 17 Feb 2001 17:39:01 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:24845
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132047AbRBQWip>; Sat, 17 Feb 2001 17:38:45 -0500
Date: Sat, 17 Feb 2001 14:38:19 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Dennis <dennis@etinc.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux stifles innovation...
In-Reply-To: <5.0.0.25.0.20010217150612.0390d950@mail.etinc.com>
Message-ID: <Pine.LNX.4.10.10102171423120.31811-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, Dennis wrote:

> good commercial drivers dont need fixing. another point. You are arguing 
> that having source is required to fix crappy code, which i agree with.
> 
> You "guys" like to have source, and there is nothing wrong with that. But 
> requiring that all code be distributed as source DOES stifle innovation. 
> Its as simple as that.

And when your customer gets screw because you refuse to update your binary
driver because you do not know or have had the chance to follow any
evolving API, you are going to blame us in OPEN source, right.

Meanwhile the API changes may have boosted the performance factor and you
have screw yourself and customer base because you are to lame to see the
value of open source.

Some time ago I proposed CLAPI, and you are one of the venders that would 
benefit from such a beast.  This model would have required you to LGPL a
kernel library that would have all the functional IP (that is not IP) that
is to lame to be placed into the hardware.  If your hardware is so flakey
that you have to pump/prime it for operations....well....you get the
point.

If I recall you and your company on one of the worst offenders of taking
code (GPL or not) and changing it and putting it out as binaries.  I am
surprized that you have not been taken down yet.  Then if someone asks for
the return of the code base and changes because they can under the terms
of the license that you removed from that code, you charge them a fee and
suggest actionable terms if any disclosure into the public form from
where it came.

Regards,

Andre Hedrick
Linux ATA Development

