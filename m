Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270703AbTHFKsw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274996AbTHFKsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:48:51 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:30987 "EHLO
	mail3.cybertrails.com") by vger.kernel.org with ESMTP
	id S270703AbTHFKsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:48:50 -0400
Date: Wed, 6 Aug 2003 03:48:42 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Grant Miner <mine0057@mrs.umn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Tests
Message-Id: <20030806034842.1ec1ba38.dickson@permanentmail.com>
In-Reply-To: <3F306858.1040202@mrs.umn.edu>
References: <3F306858.1040202@mrs.umn.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Aug 2003 21:30:48 -0500, Grant Miner wrote:

> The first item number is time, in seconds, to complete the test (lower 
> is better).  The second number is CPU use percentage (lower is better).
> 
> reiser4 171.28s, 30%CPU (1.0000x time; 1.0x CPU)
> reiserfs 302.53s, 16%CPU (1.7663x time; 0.53x CPU)
> ext3 319.71s, 11%CPU	(1.8666x time; 0.36x CPU)
> xfs 429.79s, 13%CPU (2.5093x time; 0.43x CPU)
> jfs 470.88s, 6%CPU (2.7492x time 0.02x CPU)

That should be 0.20x CPU for jfs, right?

	-Paul

