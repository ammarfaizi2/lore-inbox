Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVACOiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVACOiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 09:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVACOiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 09:38:51 -0500
Received: from albireo.enyo.de ([212.9.189.169]:61083 "EHLO albireo.enyo.de")
	by vger.kernel.org with ESMTP id S261466AbVACOiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 09:38:50 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
References: <20050102200032.GA8623@lst.de> <m1mzvry3sf.fsf@muc.de>
	<20050102203005.GA9491@lst.de> <m1is6fy2vm.fsf@muc.de>
	<20050102223650.GA5818@localhost> <20050102233039.GB71343@muc.de>
	<20050103002102.GA5987@localhost> <20050103003237.GA89490@muc.de>
Date: Mon, 03 Jan 2005 15:38:41 +0100
In-Reply-To: <20050103003237.GA89490@muc.de> (Andi Kleen's message of "3 Jan
	2005 01:32:37 +0100, Mon, 3 Jan 2005 01:32:37 +0100")
Message-ID: <87acrqwpam.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen:

>> think the dogma of "no policy in the kernel" is a good one to follow
>> here:  it ignores the problem and creates new ones.
>
> The kernel just assumes that root knows what he/she/it is doing.

Is there any documentation that says that you must load security
modules immediately?  If there isn't, this assumption is a bit
far-fetched.
