Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTKZLaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 06:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTKZLaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 06:30:46 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7040 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264152AbTKZLap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 06:30:45 -0500
Date: Wed, 26 Nov 2003 11:35:03 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311261135.hAQBZ3Ku000202@81-2-122-30.bradfords.org.uk>
To: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p73fzgbzca6.fsf@verdi.suse.de>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
 <20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
 <p73fzgbzca6.fsf@verdi.suse.de>
Subject: Re: Fire Engine??
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Andi Kleen <ak@suse.de>:
> "David S. Miller" <davem@redhat.com> writes:
> > 
> > So his claim is that, in their mesaurements, "CPU utilization"
> > was lower in their stack.  Was he using 2.6.x and TSO capable
> > cards on the Linux side?  If not, it's not apples to apples
> > against are current upcoming technology.
> 
> Maybe they just have a better copy_to_user(). That eats most time anyways.
> 
> I think there are definitely areas of improvements left in current TCP.
> It has gotten quite fat over the last years.

On the subject of general networking performance in Linux, I thought
this set of benchmarks was quite interesting:

http://bulk.fefe.de/scalability/

particularly the 2.4 -> 2.6 comparisons.

John.
