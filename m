Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266131AbUGOH1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUGOH1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 03:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUGOH1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 03:27:38 -0400
Received: from holomorphy.com ([207.189.100.168]:4515 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266131AbUGOH1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 03:27:37 -0400
Date: Thu, 15 Jul 2004 00:27:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@borntraeger.net
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, lmb@suse.de
Subject: Re: Re: [PATCH] was: [RFC] removal of sync in panic
Message-ID: <20040715072734.GS3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@borntraeger.net, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, lmb@suse.de
References: <5636222$108987528740f62d57f21052.04964585@config20.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5636222$108987528740f62d57f21052.04964585@config20.schlund.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> schrieb am 15.07.2004, 
>> I've seen SMP boxen run interrupt handlers for ages after panicking,
>> but I never thought much of it.

On Thu, Jul 15, 2004 at 09:10:01AM +0200, linux-kernel@borntraeger.net wrote:
> I have seen more than just interupt handlers.I was able to log in via
> ssh. After typing dmesg I saw 2 panics and the system was still up.

Jesus fscking H. Christ wtf is going on here?


-- wli
