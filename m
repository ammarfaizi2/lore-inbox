Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVCBXs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVCBXs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVCBXoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:44:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29878 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261186AbVCBXm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:42:58 -0500
Message-ID: <42264F6C.8030508@pobox.com>
Date: Wed, 02 Mar 2005 18:42:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMO too confusing.

And it exacerbates an on-going issue:  we are moving away from "release 
early, release often", as this proposal just pushes the list of pending 
stuff back even further.

Developers right now are sitting on big piles, and pushing that back 
even further means every odd release means you are creating a 
2.4.x/2.5.x backport situation every two releases.

To take a radical position on the other side, I would prefer a weekly 
snapshot as the release, staging invasive things in -mm.

And I think -mm is not enough, even.  We have to come up with new ways 
to manage this ever-increasing flow of data into our tree.

	Jeff



