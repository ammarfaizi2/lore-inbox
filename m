Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbUJ0QM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUJ0QM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbUJ0QM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:12:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:25759 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262490AbUJ0QJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:09:02 -0400
Subject: Re: Let's make a small change to the process
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Randy Dunlap <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Jones <davej@redhat.com>
In-Reply-To: <200410262220_MC3-1-8D36-77F@compuserve.com>
References: <200410262220_MC3-1-8D36-77F@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098889516.4302.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 16:05:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-27 at 03:17, Chuck Ebbert wrote:
> > If the goal of -ac is to only include those fixes, why can't we rename
> > it in something more "intuitive" for the final users ?
> > Do you see what I mean ?
> 
>   AFAICT -ac is not supposed to be a complete collection of bugfixes.
>   2.6.9-ac3 was certainly missing a lot of them (haven't seen -ac4 yet.)

The goal of -ac is to contain the stuff I personally consider important.
A lot of the smaller bugfixes individually are fine but a 'complete set
of bugfixes' turns into a large change set and then needs an entire
validation and release cycle of its own.

Each 2.6.10rc change I merged is on the basis of reward >> risk.

I don't care if its 2.6.9-ac or 2.6.9.4 personally but it's for Linus to
decide if he wants to do that and who he wants to make keeper of the
2.6.x.y tree if anyone.

Alan

