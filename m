Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWBNFZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWBNFZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWBNFZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:25:00 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:54917 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030472AbWBNFY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:24:58 -0500
Date: Tue, 14 Feb 2006 10:57:27 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Suryanarayanan, Rajaram" <Rajaram.Suryanarayanan@in.unisys.com>
Cc: "KUROSAWA Takahiro" <kurosawa@valinux.co.jp>,
       <linux-kernel@vger.kernel.org>, <ckrm-tech@lists.sourceforge.net>,
       <balbir.singh@in.ibm.com>
Subject: Re: [ckrm-tech] [PATCH 1/2] add a CPU resource controller
Message-ID: <20060214052727.GC28942@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <88299102B8C1F54BB5C8E47F30B2FBE201E95CD2@inblr-exch1.eu.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88299102B8C1F54BB5C8E47F30B2FBE201E95CD2@inblr-exch1.eu.uis.unisys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 10:30:13AM +0530, Suryanarayanan, Rajaram wrote:
> Is this patch under discussion a new CPU resource controller for 2.6.15
> ?

No, the patch does not talk of a new controller. The patch only fixes some 
problem with the existing controller. Hope this clarifies!

-- 
Regards,
vatsa
