Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317418AbSGDOGy>; Thu, 4 Jul 2002 10:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317419AbSGDOGx>; Thu, 4 Jul 2002 10:06:53 -0400
Received: from smtp.intrex.net ([209.42.192.250]:18705 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S317418AbSGDOGw>;
	Thu, 4 Jul 2002 10:06:52 -0400
Date: Thu, 4 Jul 2002 10:15:01 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020704101501.A19611@tricia.dyndns.org>
References: <20020619113734.D2658@redhat.com> <E17LF65-0001K4-00@starship> <20020621160659.C2805@redhat.com> <E17PyXt-0000hm-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17PyXt-0000hm-00@starship>; from phillips@arcor.de on Thu, Jul 04, 2002 at 06:48:45AM +0200
X-Declude-Sender: jlnance@intrex.net [216.181.42.97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 06:48:45AM +0200, Daniel Phillips wrote:
> > behaviour under certain application workloads.  With the half-md4, at
> > least we can expect decent worst-case behaviour unless we're under
> > active attack (ie. only maliscious apps get hurt).
> 
> OK, anti-hash-attack is on the list of things to do, and it's fairly
> clear how to go about it:

Is it really worth the trouble and complexity to do anti-hash-attack?
What is the worst that could happen if someone managed to create a bunch
of files that hashed to the same value?

Jim
