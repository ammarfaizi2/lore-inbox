Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965272AbVLRUGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965272AbVLRUGH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 15:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbVLRUGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 15:06:07 -0500
Received: from lame.durables.org ([64.81.244.120]:62095 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S965272AbVLRUGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 15:06:04 -0500
Subject: Re: [openib-general] Re: [PATCH 10/13]  [RFC] ipath verbs, part 1
From: Robert Walsh <rjwalsh@pathscale.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051218195922.GC31184@us.ibm.com>
References: <200512161548.zxp6FKcabEu47EnS@cisco.com>
	 <200512161548.W9sJn4CLmdhnSTcH@cisco.com>
	 <20051218195922.GC31184@us.ibm.com>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 12:05:58 -0800
Message-Id: <1134936358.5826.2.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 11:59 -0800, Paul E. McKenney wrote:
> On Fri, Dec 16, 2005 at 03:48:55PM -0800, Roland Dreier wrote:
> > First half of ipath verbs driver
> 
> Some RCU-related questions interspersed.  Basic question is "where is
> the lock-free read-side traversal?"

Good question.  I'll take a closer look.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


