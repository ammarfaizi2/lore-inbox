Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSBCBpW>; Sat, 2 Feb 2002 20:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSBCBpL>; Sat, 2 Feb 2002 20:45:11 -0500
Received: from adsl-77-220.38-151.net24.it ([151.38.220.77]:1801 "EHLO
	karis.localdomain") by vger.kernel.org with ESMTP
	id <S285073AbSBCBo7>; Sat, 2 Feb 2002 20:44:59 -0500
Message-Id: <200202030147.g131lvB26446@karis.localdomain>
Date: Sun, 3 Feb 2002 02:47:57 +0100
From: Francesco Munda <syylk@libero.it>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130033906.I32317@havoc.gtf.org>
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com>
	<200201290137.g0T1bwB24120@karis.localdomain>
	<a354iv$ai9$1@penguin.transmeta.com>
	<200201300803.g0U83uB24903@karis.localdomain>
	<20020130033906.I32317@havoc.gtf.org>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002 03:39:06 -0500
Jeff Garzik <garzik@havoc.gtf.org> wrote:

> 2.5.x is the reference development tree.
> 
> [...]

Ok, I buy it.

The amount of messages, and thoughts on the subject, fairly satisfied me. I
wanted to see a reaction, and I indeed saw one. And I like what I've seen:
the point Rob brought up was not dismissed lightheartedly, but instead
spurred a discussion on many aspects of kernel development. Adoption of BK,
maintainers hierarchies, trust relationships between demigods, patch handling
clarifications, you name it...

Who can disagree that talking about these topics, finding solutions (to
existing and future problems), and in general doing reality checks is a good
thing?

And the "small patches maintainer" is a figure that should be there. World
will keep spinning if nobody takes the buck, but having one such maintainer
has been generally greeted as a good idea.

We can have many trees to play with to develop different changes, but that
trivial one-line fixup should be in every tree, not just in "my favorite
maintainer's" tree. Risking a wipeout while testing a new scheduler/VM/dev
handler is one thing. Risking a wipeout for a bug that's patched in
everyone's else tree but not in my own, is another. :)

Trivial fixes and largish changes should be handled in different ways, this
thread seems to have summed up. Maybe by different people, to split some
workload more evenly.

Many interesting points were touched. Let's wait and see.

-- Francesco
