Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTLCVXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTLCVXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:23:25 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:27791 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S261885AbTLCVXV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:23:21 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 includes Andrea's VM?
References: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov>
	<20031203183719.GD24651@dualathlon.random>
	<9cfu14hbqvz.fsf@rogue.ncsl.nist.gov>
	<20031203210522.GF24651@dualathlon.random>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Wed, 03 Dec 2003 16:23:18 -0500
In-Reply-To: <20031203210522.GF24651@dualathlon.random> (Andrea Arcangeli's
 message of "Wed, 3 Dec 2003 22:05:22 +0100")
Message-ID: <9cf1xrlbnp5.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> Just to try the driver you can go with plain 2.4.23 right now, the inode
> and bh troubles showup in a few days normally, not in a few minutes,
> however it depends on your workload. For example with 12G you probably
> want to avoid updatedb until you apply all the vm fixes.

My workload eats inodes and bhs for lunch.  I'll try merging 05_vm_*.
Thanks!  

Ian

