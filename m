Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVEZOMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVEZOMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 10:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVEZOMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 10:12:46 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:39086 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261222AbVEZOMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 10:12:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2*: CD recorder problem
Date: Thu, 26 May 2005 16:12:45 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
References: <200504131837.42930.rjw@sisk.pl> <20050525223057.051c5572.akpm@osdl.org>
In-Reply-To: <20050525223057.051c5572.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261612.46327.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 26 of May 2005 07:30, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Hi,
> > 
> > On the kernels above and including 2.6.12-rc2 k3b is unable to operate my
> > IDE CD recorder.  First time (after a fresh reboot) I start it, it detects the
> > recorder properly, but then it refuses to work (it says the media is unknown).
> > After k3b is restarted, it can't even detect the drive.
> > 
> > The problem does not occur on 2.6.11.  I don't know whether it happens for the
> > kernels between 2.6.11 and 2.6.12-rc2, but I can check if that's necessary.
> > 
> 
> Is this still happening in 2.6.12-rc5?

No, it  is not. :-)

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
