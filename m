Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSJHJFW>; Tue, 8 Oct 2002 05:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261554AbSJHJFV>; Tue, 8 Oct 2002 05:05:21 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:30665 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261545AbSJHJFV>;
	Tue, 8 Oct 2002 05:05:21 -0400
Date: Tue, 8 Oct 2002 11:11:01 +0200
From: bert hubert <ahu@ds9a.nl>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: experiences with 2.5.40 on a busy usenet news server
Message-ID: <20021008091101.GA25131@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	linux-kernel@vger.kernel.org
References: <anu60s$oev$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anu60s$oev$1@ncc1701.cistron.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 08:46:20AM +0000, Miquel van Smoorenburg wrote:
> Just FYI:
> 
> So I booted 2.5.40 with the raid0 fix on our usenet news peering
> server yesterday. It is a box that exchanges binary feeds with
> about 40 peers, 400 GB/day in, 600 GB/day out.

If you'd dare to try a next time, could you try 2.5.4x-mm ? It tends to be
far more well tuned and is where vm development takes place.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
