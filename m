Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265794AbSKAWNi>; Fri, 1 Nov 2002 17:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265795AbSKAWNi>; Fri, 1 Nov 2002 17:13:38 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:22007 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S265794AbSKAWNh>; Fri, 1 Nov 2002 17:13:37 -0500
Date: Fri, 1 Nov 2002 14:19:27 -0800
From: Chris Wright <chris@wirex.com>
To: Colin Burnett <cburnett@fractal.candysporks.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: file change notification
Message-ID: <20021101141927.A16607@figure1.int.wirex.com>
Mail-Followup-To: Colin Burnett <cburnett@fractal.candysporks.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <1036186261.3dc2f2959a2a0@www.candysporks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1036186261.3dc2f2959a2a0@www.candysporks.org>; from cburnett@fractal.candysporks.org on Fri, Nov 01, 2002 at 03:31:01PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Colin Burnett (cburnett@fractal.candysporks.org) wrote:
> Is there notification to processes on file change?

have you looked at dnotify? Documentation/dnotify.txt

-chris
