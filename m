Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279803AbRKAVfI>; Thu, 1 Nov 2001 16:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279802AbRKAVe6>; Thu, 1 Nov 2001 16:34:58 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:38069 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S279800AbRKAVek>; Thu, 1 Nov 2001 16:34:40 -0500
Date: Thu, 1 Nov 2001 14:34:05 -0700
Message-Id: <200111012134.fA1LY5H32133@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Nick LeRoy <nleroy@cs.wisc.edu>, "Jeffrey W. Baker" <jwbaker@acm.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6
 (unkillable processes)
In-Reply-To: <Pine.LNX.4.33L.0111011839120.447-100000@duckman.distro.conectiva>
In-Reply-To: <200111012035.fA1KZMG11816@schroeder.cs.wisc.edu>
	<Pine.LNX.4.33L.0111011839120.447-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> On Thu, 1 Nov 2001, Nick LeRoy wrote:
> 
> > Yeah, I think that I know what I'm talking about.  The question
> > was:  Should devfs be fixed, or should xterm be fixed.
> 
> If any random malicious user can crash the machine through
> devfs, I think the answer to this question is quite obvious.
> 
> The security hole should be fixed.

Agreed. I will.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
