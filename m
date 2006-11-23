Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933696AbWKWN14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933696AbWKWN14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933692AbWKWN14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:27:56 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:52025 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S933696AbWKWN1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:27:55 -0500
In-Reply-To: <adaslgbaxsu.fsf@cisco.com>
Subject: Re: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe address	to
 determine pending work requests
To: Roland Dreier <rdreier@cisco.com>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org,
       openib-general@openib.org
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OFCFF36ACF.6FF07D9E-ONC125722F.00499C9C-C125722F.0049F685@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Thu, 23 Nov 2006 14:31:21 +0100
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF882 | September 26, 2006) at
 23/11/2006 14:31:22
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland!
> OK.  After thinking about this, I'm going to queue it for 2.6.20 --
> we're _way_ too close to the 2.6.19 final release to put in patches
> that aren't either small and obvious, or fix a problem someone hit in
> real life.
That's fair. I understand your decision. And thanks for queueing for
2.6.20. Can you please brief me on patch procedures for post-2.6.19?
Regards
Nam

