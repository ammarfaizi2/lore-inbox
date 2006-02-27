Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWB0UZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWB0UZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWB0UZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:25:51 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:897 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751516AbWB0UZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:25:50 -0500
Date: Mon, 27 Feb 2006 12:25:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: stable@kernel.org, James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [stable] [PATCH 2.6.15.4 update] sd: fix memory corruption with broken mode page headers
Message-ID: <20060227202508.GD3883@sorel.sous-sol.org>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de> <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de> <tkrat.ac90e0d775a5c272@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.ac90e0d775a5c272@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
> sd: fix memory corruption with broken mode page headers

Thanks, queued this one for -stable.
-chris
