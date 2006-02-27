Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWB0MBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWB0MBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWB0MBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:01:05 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:48516 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750997AbWB0MBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:01:04 -0500
Date: Mon, 27 Feb 2006 17:30:53 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: dipankar@in.ibm.com, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 4/7] Add sysctl for delay accounting
Message-ID: <20060227120053.GD22492@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141028322.5785.60.camel@elinux04.optonline.net> <1141028784.2992.58.camel@laptopd505.fenrus.org> <4402BA93.5010302@watson.ibm.com> <1141029743.2992.71.camel@laptopd505.fenrus.org> <20060227090414.GA18941@in.ibm.com> <1141031595.2992.76.camel@laptopd505.fenrus.org> <20060227101124.GA22492@in.ibm.com> <1141039458.2992.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141039458.2992.94.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> well you assume you CAN walk all tasks... which is something afaik
> that's being deprecated ;)
>

Thanks for clarifying that. We will need to revisit this function as a result
of the proposed changes (when they happen).

Balbir 
