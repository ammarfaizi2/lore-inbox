Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVHQOgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVHQOgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 10:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVHQOgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 10:36:14 -0400
Received: from souterrain.chygwyn.com ([194.39.143.233]:238 "EHLO
	souterrain.chygwyn.com") by vger.kernel.org with ESMTP
	id S1751143AbVHQOgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 10:36:13 -0400
Date: Wed, 17 Aug 2005 15:45:24 +0100
From: Steven Whitehouse <steve@chygwyn.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Suzanne Wood <suzannew@cs.pdx.edu>, linux-kernel@vger.kernel.org,
       walpole@cs.pdx.edu, patrick@tykepenguin.com
Subject: Re: rcu read-side protection
Message-ID: <20050817144524.GA28208@souterrain.chygwyn.com>
References: <000f01c5a2bf$f8e752d0$6401a8c0@woodworkxi42l4> <20050817020156.GF1319@us.ibm.com> <20050817082552.GA25537@souterrain.chygwyn.com> <20050817141438.GD1300@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817141438.GD1300@us.ibm.com>
User-Agent: Mutt/1.4.1i
Organization: ChyGwyn Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 17, 2005 at 07:14:38AM -0700, Paul E. McKenney wrote:
[snip]
> How about the following patch?  Untested, but seems pretty straightforward.
> 
> 							Thanx, Paul
> 


That would be my preferred fix. If Patrick is happy with that, then please
pass it on to Dave M with our respective blessings :-) Thanks,

Steve.

