Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSKRC0f>; Sun, 17 Nov 2002 21:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSKRC0f>; Sun, 17 Nov 2002 21:26:35 -0500
Received: from franka.aracnet.com ([216.99.193.44]:50119 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261354AbSKRC0c>; Sun, 17 Nov 2002 21:26:32 -0500
Date: Sun, 17 Nov 2002 18:30:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <654847351.1037557827@[10.10.2.3]>
In-Reply-To: <20021117.113319.126503551.davem@redhat.com>
References: <20021117.113319.126503551.davem@redhat.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    OK, the easy way to fix this is to change the default owner for the
>    category to someone else who can filter the bugs as they arrive in
>    "OPEN" state. After filtering, they can be moved to "ASSIGNED" state,
>    and the owner changed to you ... how does that sound?
> 
> This funnels the work to two people, it's still wildly inefficient.
> 
> What is so difficult about allowing anyone to review and close a bug?

That might work if it's open to a set of trusted maintainers 
(eg. the set of current bugzilla subsystem maintainers), but I don't
think totally open universal access is a good idea. A pool of people
is probably the way to go here.

M.

