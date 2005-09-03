Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbVICGkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbVICGkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVICGkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:40:14 -0400
Received: from smtp.istop.com ([66.11.167.126]:26551 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1750701AbVICGkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:40:13 -0400
From: Daniel Phillips <phillips@istop.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: GFS, what's remaining
Date: Sat, 3 Sep 2005 02:42:36 -0400
User-Agent: KMail/1.8
Cc: Andi Kleen <ak@suse.de>, linux clustering <linux-cluster@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <p73fysnqiej.fsf@verdi.suse.de> <20050903001628.GH21228@ca-server1.us.oracle.com>
In-Reply-To: <20050903001628.GH21228@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509030242.36506.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2005 20:16, Mark Fasheh wrote:
> As far as userspace dlm apis go, dlmfs already abstracts away a large part
> of the dlm interaction...

Dumb question, why can't you use sysfs for this instead of rolling your own?

Side note: you seem to have deleted all the 2.6.12-rc4 patches.  Perhaps you 
forgot that there are dozens of lkml archives pointing at them?

Regards,

Daniel
