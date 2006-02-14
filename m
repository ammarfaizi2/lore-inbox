Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWBNFgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWBNFgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWBNFgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:36:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:8094 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030208AbWBNFgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:36:23 -0500
Date: Tue, 14 Feb 2006 11:08:52 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: "Suryanarayanan, Rajaram" <Rajaram.Suryanarayanan@in.unisys.com>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       balbir.singh@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 1/2] add a CPU resource controller
Message-ID: <20060214053852.GD28942@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <88299102B8C1F54BB5C8E47F30B2FBE201E95CD2@inblr-exch1.eu.uis.unisys.com> <20060214052604.7EA9174031@sv1.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214052604.7EA9174031@sv1.valinux.co.jp>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 02:26:04PM +0900, KUROSAWA Takahiro wrote:
> It's not a forward port of the existing CPU resource controller 
> but a new CPU resource controller for CKRM.  Its resource control
> mechanism is different from that of the existing one.

Hmm ..I guess it depends on which version of CKRM you are referring when
you say "existing". When I replied earlier, I was referring to f-series.
f-series cpu controller is based on the patch you sent to lkml right?

-- 
Regards,
vatsa
