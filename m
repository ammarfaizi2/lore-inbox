Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264843AbRFYGeI>; Mon, 25 Jun 2001 02:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRFYGd6>; Mon, 25 Jun 2001 02:33:58 -0400
Received: from [209.250.58.187] ([209.250.58.187]:31754 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S264843AbRFYGdx>; Mon, 25 Jun 2001 02:33:53 -0400
Date: Mon, 25 Jun 2001 01:32:41 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Andy Ward <andyw@edafio.com>
Cc: linux-kernel@vger.kernel.org
Subject: VIA Southbridge bug (Was: Crash on boot (2.4.5))
Message-ID: <20010625013241.A23425@hapablap.dyn.dhs.org>
In-Reply-To: <3BDF3E4668AD0D49A7B0E3003B294282BC94@etmain.edafio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDF3E4668AD0D49A7B0E3003B294282BC94@etmain.edafio.com>; from andyw@edafio.com on Mon, Jun 25, 2001 at 01:17:57AM -0500
X-Uptime: 1:28am  up 2 days, 10 min,  1 user,  load average: 1.74, 1.64, 1.51
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great, glad to here it.  Who (if anyone) is still attempting to unravel
the puzzle of the Via southbridge bug?  You, Andy, should try and get in
touch with them and help debug this thing, if you're up to it.

On Mon, Jun 25, 2001 at 01:17:57AM -0500, Andy Ward wrote:
> Well, I have tried your suggestion, and it works beautifully...  The
> only change I made was to the cpu type (to 686), and everything *just*
> works now...  Thanks, all!!!
> 
> > From the look of things, you're being bitten by the VIA southbridge
> > problem.  As I've gathered, its some sort of interaction with that chip
> > and the 3DNow! fast copy routines the kernel uses.
> > 
> > If you compile the kernel for a 686, does the problem go away?  What
> > about 586 or lower?  If so, I believe there are some people working on
> > finding common aspects of the hardware that experience this problem,
> > though I don't remember who.  You should get in contact with them, or
> > they might get into contact with you.
> > 
> > Good luck on working this out.
> > -- 
> > -Steven
> > In a time of universal deceit, telling the truth is a revolutionary act.
> > 			-- George Orwell
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
