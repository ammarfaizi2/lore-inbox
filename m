Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279370AbRJ2XBu>; Mon, 29 Oct 2001 18:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279582AbRJ2XBk>; Mon, 29 Oct 2001 18:01:40 -0500
Received: from mail2.home.nl ([213.51.129.226]:52631 "EHLO mail2.home.nl")
	by vger.kernel.org with ESMTP id <S279370AbRJ2XBZ>;
	Mon, 29 Oct 2001 18:01:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: elko <elko@home.nl>
To: Hugh Dickins <hugh@veritas.com>, Marko Rauhamaa <marko@pacujo.nu>
Subject: Re: Need blocking /dev/null
Date: Tue, 30 Oct 2001 00:03:42 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110292144120.1085-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0110292144120.1085-100000@localhost.localdomain>
X-Owner: ElkOS
MIME-Version: 1.0
Message-Id: <01103000034207.13457@ElkOS>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 October 2001 22:45, Hugh Dickins wrote:
> On Mon, 29 Oct 2001, Marko Rauhamaa wrote:
> > I noticed that I need a pseudodevice that opens normally but blocks
> > all reads (and writes). The only way out would be through a signal.
> > Neither /dev/zero nor /dev/null block, but is there some other
> > standard device that would do the job?
> >
> > If there isn't, writing such a pseudodevice would be trivial. What
> > should it be called? Any chance of including that in the kernel?
>
> /dev/never

sorry, the bait was too obvious: /dev/microsoft

-- 
ElkOS: 12:01am up 6 days, 9:32, 3 users, load average: 2.54, 2.40, 2.27
bofhX: appears to be a Slow/Narrow SCSI-0 Interface problem

