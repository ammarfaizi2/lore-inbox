Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVHTGcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVHTGcI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 02:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVHTGcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 02:32:07 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:43484 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S1751083AbVHTGcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 02:32:06 -0400
Date: Fri, 19 Aug 2005 23:31:59 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: Daniel Phillips <phillips@istop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permissions don't stick on ConfigFS attributes
Message-ID: <20050820063159.GB3168@ca-server1.us.oracle.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Daniel Phillips <phillips@istop.com>, linux-kernel@vger.kernel.org
References: <200508201050.51982.phillips@istop.com> <20050820030117.GA775@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050820030117.GA775@kroah.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 08:01:17PM -0700, Greg KH wrote:
> The recent changes to sysfs should be ported to configfs to do this.

	Yeah, I've been meaning to do something, and resusing code is
always a good plan.  Hopefully I can get to this soon.
 
Joel

-- 

"I don't know anything about music. In my line you don't have
 to."
        - Elvis Presley

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
