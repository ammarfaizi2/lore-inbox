Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285438AbRLGTHY>; Fri, 7 Dec 2001 14:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285440AbRLGTHT>; Fri, 7 Dec 2001 14:07:19 -0500
Received: from bitmover.com ([192.132.92.2]:50065 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285438AbRLGTHD>;
	Fri, 7 Dec 2001 14:07:03 -0500
Date: Fri, 7 Dec 2001 11:07:02 -0800
From: Larry McVoy <lm@bitmover.com>
To: Daniel Bergman <d-b@home.se>
Cc: Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Henning Schmiedehausen <hps@intermeta.de>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011207110702.Q27589@work.bitmover.com>
Mail-Followup-To: Daniel Bergman <d-b@home.se>,
	Larry McVoy <lm@bitmover.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Henning Schmiedehausen <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011207080603.B6983@work.bitmover.com> <2692295916.1007714643@[10.10.1.2]> <20011207092314.F27589@work.bitmover.com> <3C1111D0.9B7E30FF@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C1111D0.9B7E30FF@home.se>; from d-b@home.se on Fri, Dec 07, 2001 at 08:00:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 08:00:32PM +0100, Daniel Bergman wrote:
> > My pay job is developing a distributed source management system which works
> > by replication.  We already have users who put all the etc files in it and
> > manage them that way.  Works great.  It's like rdist except it never screws
> > up and it has merging.
> 
> I'm just curious, what about security? Is this done in clear-text? 
> Sounds dangerous to put /etc/shadow, for example, in clear-text on the
> cable.

BitKeeper can, and typically does, use ssh as a transport.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
