Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTFIUSi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTFIUSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:18:38 -0400
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:21508 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP id S261688AbTFIUSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:18:37 -0400
Message-ID: <3EE4EEA5.60106@ixiacom.com>
Date: Mon, 09 Jun 2003 13:31:33 -0700
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug 791] New: motorola sandpoint code does not compile
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> The Motorola Sandpoint code (along with many other MPC107 based
> platforms) is out of date in 2.5.  Is there a way to close this bug and
> have it reflect that?

Sure -- just change the name of the bug to "2.5 tree out of date
with respect to MPC107 platforms" and add a comment saying
where the up to date code is that needs to be merged in.
Then leave it open to reflect the fact that the vger tree
is out of date for these platforms.

Isn't this an example of the eternal struggle between the vger tree and
the trees maintained by the ppc, arm, and SH teams?  I don't
have any idea how far apart the trees are at the moment,
but I use x86, ppc, and SH at work, and would like to
use the same kernel tree for all three, so this is a bit
of a sore point for me.

- Dan

