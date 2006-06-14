Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWFNA3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWFNA3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWFNA3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:29:44 -0400
Received: from relay01.pair.com ([209.68.5.15]:15627 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932374AbWFNA3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:29:43 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: bidulock@openss7.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Date: Tue, 13 Jun 2006 19:29:19 -0500
User-Agent: KMail/1.9.3
Cc: Ben Greear <greearb@candelatech.com>,
       Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <200606131906.16683.chase.venters@clientec.com> <20060613181801.A8460@openss7.org>
In-Reply-To: <20060613181801.A8460@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131929.41985.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 19:17, Brian F. G. Bidulock wrote:
> Chase,
>
> On Tue, 13 Jun 2006, Chase Venters wrote:
> > I'm trying to imagine what kind of legitimate non-GPL modules might
> > use them.
>
> Example: in-kernel RTP implementation derived from AT&T rtp-lib
> implementation (non-GPL compatible license) utilizing this kernel
> interface for UDP socket access.

I don't mean to be obtuse, but the "Non-exclusive Non-commercial Limited-use 
Source" license seems to make something like that have limited usefulness in 
general. That is -- unless one were to obtain a commercial license from AT&T, 
but then that starts falling into the domain of what is likely prohibited by 
the GPL (some sort of proprietary work actually _derived_ off the kernel 
rather than just supporting it in some way).

But I did ask for examples...

Thanks,
Chase
