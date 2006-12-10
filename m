Return-Path: <linux-kernel-owner+w=401wt.eu-S1758875AbWLJBQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875AbWLJBQO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 20:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758877AbWLJBQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 20:16:14 -0500
Received: from nebensachen.de ([195.225.107.202]:57934 "EHLO nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758875AbWLJBQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 20:16:13 -0500
From: Elias Oltmanns <eo@nebensachen.de>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Pavel Machek <pavel@ucw.cz>, Christoph Schmid <chris@schlagmichtod.de>,
       linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
References: <7ibks-1fg-15@gated-at.bofh.it> <7kpjn-7th-23@gated-at.bofh.it>
	<7kDFF-8rd-29@gated-at.bofh.it> <87d5783fms.fsf@denkblock.local>
	<20061130171910.GD1860@elf.ucw.cz> <87k61bpuk4.fsf@denkblock.local>
	<20061202115709.GC4030@ucw.cz> <87wt50wokd.fsf@denkblock.local>
X-Hashcash: 1:20:061210:jens.axboe@oracle.com::/f/48lNrSYjn8LCv:00000000000000000000000000000000000000000IU3
X-Hashcash: 1:20:061210:linux-kernel@vger.kernel.org::knX4RSwSRYtYsP1q:00000000000000000000000000000000000HY
X-Hashcash: 1:20:061210:chris@schlagmichtod.de::7h4J74HARg3wdPbM:0000000000000000000000000000000000000000X40
X-Hashcash: 1:20:061210:pavel@ucw.cz::FGbkkFUNfH+2BKgF:000001j+r
Date: Sun, 10 Dec 2006 02:16:02 +0100
In-Reply-To: <87wt50wokd.fsf@denkblock.local> (Elias Oltmanns's message of
	"Sun\, 10 Dec 2006 02\:02\:26 +0100")
Message-ID: <87psaswnxp.fsf@denkblock.local>
User-Agent: Gnus/5.110006 (No Gnus v0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Elias Oltmanns <eo@nebensachen.de> wrote:
> So, here is a patch in which your remarks and suggestions have been
> incorporated. Additionally, I've added the requested kernel doc file
> and another sysfs attribute called protect_method. The usage of this
> attribute is described in Documentation/block/disk-protection.txt.

Just forgot to mention that your suggestions haven't been implemented
yet. Thats because I'm only gradually beginning to understand the
reasoning and how it might work out in the end. It will probably take
me another weekend (or more) to come up with something fit for
discussion. Bare with me, I'm rather busy at the moment and still new
to the block layer (or kernel code, for that matter).

Regards,

Elias
