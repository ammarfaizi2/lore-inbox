Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270292AbRHNKTB>; Tue, 14 Aug 2001 06:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270395AbRHNKSv>; Tue, 14 Aug 2001 06:18:51 -0400
Received: from vitelus.com ([64.81.36.147]:3076 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S270292AbRHNKSo>;
	Tue, 14 Aug 2001 06:18:44 -0400
Date: Tue, 14 Aug 2001 03:18:51 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 3c905b works with 10bt hub - not with 10/100 switch
Message-ID: <20010814031851.A374@vitelus.com>
In-Reply-To: <20010814021445.A7454@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010814021445.A7454@vitelus.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 02:14:45AM -0700, Aaron Lehmann wrote:
> I've been having major problems on my network as of today.

I seem to have solved this problem.

I put in a 3c595 - same problem.

Luckily, I had the persistance to try another card. I chose to try
Client's eth0 as Server's eth2. Well, it worked.

I hope this network setup will work on a switch for longer than the
3c905b did.
