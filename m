Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbQLJHOV>; Sun, 10 Dec 2000 02:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbQLJHOL>; Sun, 10 Dec 2000 02:14:11 -0500
Received: from pm3-3-35.apex.net ([209.250.40.195]:54283 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129697AbQLJHN6>; Sun, 10 Dec 2000 02:13:58 -0500
Date: Sun, 10 Dec 2000 00:42:42 -0600
From: Steven Walter <srwalter@yahoo.com>
To: "Victor J. Orlikowski" <v.j.orlikowski@gte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Freeze and reboot with 2.4.0-test12-pre5
Message-ID: <20001210004242.A7959@hapablap.dyn.dhs.org>
Mail-Followup-To: "Victor J. Orlikowski" <v.j.orlikowski@gte.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001210000432.A7770@hapablap.dyn.dhs.org> <14899.9262.948012.985914@critterling.garfield.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14899.9262.948012.985914@critterling.garfield.home>; from v.j.orlikowski@gte.net on Sun, Dec 10, 2000 at 01:35:26AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2000 at 01:35:26AM -0500, Victor J. Orlikowski wrote:
> Steven,
> 
> 	One question:
> 	Do you have MTRR enabled?
> 	If so, a temporary workaround is to re-compile the kernel with
> it disabled.

To confirm, yes, I do have MTRR's enabled.  I'll see if that fixes it...
it hasn't happened in the past (checks uptime) 1 day and 9 hours, so

Out of curiosity, has someone found a reliable way of reproducing this?
 
> 	This is getting to be something of an epidemic.
> 	As I said, AMD's docs state that the write-combining was
> altered in the model and stepping stated. However, I would not
> consider myself *nearly* experienced enough in x86 assembler to start
> playing around with trying to work up a patch.
> 
-- 
-Steven
"Voters decide nothing.  Vote counters decide everything."
				-Joseph Stalin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
