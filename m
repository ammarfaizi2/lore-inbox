Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267877AbUHKCXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267877AbUHKCXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 22:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267878AbUHKCXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 22:23:49 -0400
Received: from holomorphy.com ([207.189.100.168]:4480 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267877AbUHKCXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 22:23:48 -0400
Date: Tue, 10 Aug 2004 19:23:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: spaminos-ker@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
Message-ID: <20040811022345.GN11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	spaminos-ker@yahoo.com, linux-kernel@vger.kernel.org
References: <20040811010116.GL11200@holomorphy.com> <20040811022143.4892.qmail@web13910.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811022143.4892.qmail@web13910.mail.yahoo.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 07:21:43PM -0700, spaminos-ker@yahoo.com wrote:
> I am not very familiar with all the parameters, so I just kept the defaults
> Anything else I could try?
> Nicolas

No. It appeared that the SPA bits had sufficient fairness in them to
pass this test but apparently not quite enough.


-- wli
