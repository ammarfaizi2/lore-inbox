Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTHTArm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbTHTArm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:47:42 -0400
Received: from holomorphy.com ([66.224.33.161]:27522 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261664AbTHTArm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:47:42 -0400
Date: Tue, 19 Aug 2003 17:48:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>, bill davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
Message-ID: <20030820004851.GD4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Lang <david.lang@digitalinsight.com>,
	Eric St-Laurent <ericstl34@sympatico.ca>,
	bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <1061338547.1000.30.camel@orbiter> <Pine.LNX.4.44.0308191731230.22008-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308191731230.22008-100000@dlang.diginsite.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 05:32:04PM -0700, David Lang wrote:
> while thinking about scaling based on CPU speed remember systems with
> variable CPU clocks (or even just variable performance like the transmeta
> CPU's)

This and/or mixed cpu speeds could make load balancing interesting on
SMP. I wonder who's tried. jejb?


-- wli
