Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUJOKj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUJOKj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 06:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267645AbUJOKj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 06:39:29 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:24449 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S267588AbUJOKjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 06:39:25 -0400
Date: Fri, 15 Oct 2004 12:39:14 +0200
To: =?iso-8859-15?Q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       debian-alpha@lists.debian.org, linux-alpha@vger.kernel.org
Subject: Re: 2.4.27, alpha arch, make bootimage and make bootpfile fails
Message-ID: <20041015103914.GA24800@gamma.logic.tuwien.ac.at>
References: <20041012173344.GA21846@gamma.logic.tuwien.ac.at> <20041013233247.A11663@jurassic.park.msu.ru> <20041014130035.GA4152@gamma.logic.tuwien.ac.at> <yw1xis9d8b9b.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xis9d8b9b.fsf@ford.guide>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Don, 14 Okt 2004, Måns Rullgård wrote:
> > Loading the kernel...'root=/dev/sda1'
> >
> > Halted CPU 0
> >
> > halt code = 2
> > kernel stack not valid halt
> > PC = 200000000
> > boot failure
> 
> Try building more things as modules instead of builtin, if possible.

I have reduced the whole kernel zo more or less nothing included,
besides the SCSI drivers, and the same still happens. 

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
LOCHRANZA (n.)
The long unaccomplished wail in the middle of a Scottish folk song
where the pipes nip around the corner for a couple of drinks.
			--- Douglas Adams, The Meaning of Liff
