Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269213AbRHGR1q>; Tue, 7 Aug 2001 13:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269212AbRHGR1h>; Tue, 7 Aug 2001 13:27:37 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12815 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269213AbRHGR1X>; Tue, 7 Aug 2001 13:27:23 -0400
Date: Tue, 7 Aug 2001 14:27:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: David Maynor <david.maynor@oit.gatech.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <5.1.0.14.2.20010807125043.00a864a0@pop.prism.gatech.edu>
Message-ID: <Pine.LNX.4.33L.0108071426320.1439-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, David Maynor wrote:

> 	My suggestion is instead of worrying about the swap space, or the tmp
> space, worry about an entire OS security posture(eg. filesystem, memory,
> boot). So if a machine is stolen or comprised, there is an onion of
> security protecting you, not just one or two things.

What you are saying above suspiciously sounds like:

	"I want an onion, lets leave out the layers!"

If you really want an onion, I suspect encrypted
swap will be a useful layer to have as part of your
onion...

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

