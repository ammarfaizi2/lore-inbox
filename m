Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUG2RAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUG2RAN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUG2Q7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:59:34 -0400
Received: from styx.suse.cz ([82.119.242.94]:62359 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264791AbUG2Q5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:57:51 -0400
Date: Thu, 29 Jul 2004 18:59:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patches] Input updates
Message-ID: <20040729165939.GA21130@ucw.cz>
References: <20040729140728.GA18817@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729140728.GA18817@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 04:07:28PM +0200, Vojtech Pavlik wrote:
> Hi!
> 
> Again, quite a bunch of patches has accumulated in my tree - now that
> they're well tested through Andrew's mm tree, I'd like to merge them to
> you.
> 
> There still are imperfections in atkbd/psmouse locking, but the races
> are rather hard to hit - and it's still better than before. They should
> be fixed in the next round of patches, however I'd still like to have
> this round of patches in before the next one.
> 
> Please pull from bk://kernel.bkbits.net/vojtech/input

There's two more patches needed for that set, now in the same bk tree,
to make Sun machines with Type4/Type5 keyboards work correctly.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
