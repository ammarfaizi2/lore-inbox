Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132131AbQLJTEr>; Sun, 10 Dec 2000 14:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132277AbQLJTE1>; Sun, 10 Dec 2000 14:04:27 -0500
Received: from pm3-5-36.apex.net ([209.250.41.51]:41228 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S132131AbQLJTET>; Sun, 10 Dec 2000 14:04:19 -0500
Date: Sun, 10 Dec 2000 12:34:38 -0600
From: Steven Walter <srwalter@yahoo.com>
To: David Wragg <dpw@doc.ic.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre25, S3, AMD K6-2, and MTRR....
Message-ID: <20001210123438.A9659@hapablap.dyn.dhs.org>
Mail-Followup-To: David Wragg <dpw@doc.ic.ac.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012092218280.877-100000@u> <14898.42117.34020.145433@critterling.garfield.home> <y7ru28cdtow.fsf@sytry.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <y7ru28cdtow.fsf@sytry.doc.ic.ac.uk>; from dpw@doc.ic.ac.uk on Sun, Dec 10, 2000 at 06:20:31PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2000 at 06:20:31PM +0000, David Wragg wrote:
> If I understood why the MTRR driver was doing something on the K6-2,
> then model-specific differences might make some sense.  But currently,
> I don't see why there would be any difference between "MTRR disabled"
> and "MTRR enabled, but not used".

If I'm not mistaken, X /does/ touch the MTRR's, which would explain why
it is X that crashes.

-- 
-Steven
"Voters decide nothing.  Vote counters decide everything."
				-Joseph Stalin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
