Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSCDPbp>; Mon, 4 Mar 2002 10:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSCDPbg>; Mon, 4 Mar 2002 10:31:36 -0500
Received: from codepoet.org ([166.70.14.212]:39814 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S287862AbSCDPbX>;
	Mon, 4 Mar 2002 10:31:23 -0500
Date: Mon, 4 Mar 2002 08:31:20 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: latency & real-time-ness.
Message-ID: <20020304153120.GA15313@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C82C95D.5010703@tmsusa.com> <E16hhLZ-00067I-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hhLZ-00067I-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 04, 2002 at 01:33:01AM +0000, Alan Cox wrote:
> > It might be very difficult to fix up the
> > low latency patch for the latest -ac,
> 
> You should be able to just dump out the vm part of it - Rik put that into
> rmap anyuway afaik

Any chance we will see mini-ll or the full-ll patches
in an -ac release anytime?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
