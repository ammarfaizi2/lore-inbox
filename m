Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267818AbRG2KOJ>; Sun, 29 Jul 2001 06:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267821AbRG2KN7>; Sun, 29 Jul 2001 06:13:59 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:12287 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267818AbRG2KNq>; Sun, 29 Jul 2001 06:13:46 -0400
Date: Sun, 29 Jul 2001 11:13:53 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAX_READAHEAD gives doubled throuput
Message-ID: <20010729111353.A25154@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200107280144.DAA25730@mailb.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107280144.DAA25730@mailb.telia.com>
User-Agent: Mutt/1.3.18i
From: Michael <leahcim@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 28, 2001 at 03:40:49AM +0200, Roger Larsson wrote:
> With this patch copy and diff throughput are increased from 14 respective 11 
> MB/s to 27 and 28 !!!

Alan's kernel has max-readahead as a /proc/sys/vm parameter.

-- 
Michael.
