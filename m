Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268958AbTBWVtA>; Sun, 23 Feb 2003 16:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268965AbTBWVtA>; Sun, 23 Feb 2003 16:49:00 -0500
Received: from holomorphy.com ([66.224.33.161]:57005 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268958AbTBWVs7>;
	Sun, 23 Feb 2003 16:48:59 -0500
Date: Sun, 23 Feb 2003 13:58:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High load with 2.5.x
Message-ID: <20030223215811.GJ10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org
References: <1046036480.29501.5.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046036480.29501.5.camel@chevrolet.hybel>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 10:41:21PM +0100, Stian Jordet wrote:
> I have the last 2.5.x kernels experienced a high load while idle. 1.00
> mostly. I have dual cpu, and it isn't really bothering me. But I do not
> experience this with 2.4.x kernels. I do not remember when this started,
> but since noone else complains, I just want to ask how can I find out
> what is making my load so high?

top(1) should report cpu time consumers.

-- wli
