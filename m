Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271186AbRIGFgT>; Fri, 7 Sep 2001 01:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271207AbRIGFgK>; Fri, 7 Sep 2001 01:36:10 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:37411 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271186AbRIGFfw>; Fri, 7 Sep 2001 01:35:52 -0400
Subject: Re: Linux Preemptive patch success 2.4.10-pre4 + lots of other
	patches
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010907052850Z16200-26183+115@humbolt.nl.linux.org>
In-Reply-To: <Pine.LNX.4.33.0109062135280.1643-100000@devel.office>
	<20010907051231Z16200-26183+114@humbolt.nl.linux.org>
	<999840042.1164.14.camel@phantasy> 
	<20010907052850Z16200-26183+115@humbolt.nl.linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 07 Sep 2001 01:36:15 -0400
Message-Id: <999840977.845.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-07 at 01:35, Daniel Phillips wrote:
> Sorry, I thought that was self-evident.  It's not a change, it's an option.

Oh, yes.  It is completely an option -- although I would like to see it
be the norm :)

> Yes, violent agreement.  OK, I disagree with your assessment that it's 
> a huge change.  Big in effect yes, but not in structural impact.

Right, actually I agree with you.  That was my point about using SMP
lock points.  Since it uses the existing structure for SMP concurrency,
the patch is small -- but its effects are pretty large.  Its a fairly
big deal.

> And you're right, I did think you were arguing against your own patch.

No, but I had to take that approach as it was suggested the patch be
merged for 2.4.10!

I am glad you take a pro side to the preemption issue.  Hopefully I can
get some continued support and see some work towards inclusion in 2.5. 
Any help is appreciated.

Sorry for the confusion.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

