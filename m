Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWC2REg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWC2REg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 12:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWC2REg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 12:04:36 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:25980 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750858AbWC2REf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 12:04:35 -0500
X-IronPort-AV: i="4.03,144,1141632000"; 
   d="scan'208"; a="318198849:sNHT2925283364"
To: "Dan Bar Dov" <bardov@gmail.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand 2.6.17 merge plans
X-Message-Flag: Warning: May contain useful information
References: <ada7j6f8xwi.fsf@cisco.com>
	<d6944c490603290028n70725678g287445429a9c2ae5@mail.gmail.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 29 Mar 2006 09:03:40 -0800
In-Reply-To: <d6944c490603290028n70725678g287445429a9c2ae5@mail.gmail.com> (Dan Bar Dov's message of "Wed, 29 Mar 2006 10:28:17 +0200")
Message-ID: <ada7j6d89oz.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Mar 2006 17:03:41.0426 (UTC) FILETIME=[BADF5520:01C65352]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Dan> Therefore the plan for iSER is to push it into 2.6.18

OK, thanks.

Based on all of this I'm thinking that it's better to hold back the
RDMA CM as well, since there will be no code using it ready to merge
for 2.6.17.

 - R.
