Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWBTQze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWBTQze (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbWBTQze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:55:34 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:56967 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1161033AbWBTQzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:55:33 -0500
X-IronPort-AV: i="4.02,131,1139212800"; 
   d="scan'208"; a="1777909595:sNHT32545736"
To: Christoph Raisch <RAISCH@de.ibm.com>
Cc: Roland Dreier <rolandd@cisco.com>, Heiko J Schick <SCHICKHJ@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       openib-general@openib.org
Subject: Re: [PATCH 00/22] [RFC] IBM eHCA InfiniBand adapter driver
X-Message-Flag: Warning: May contain useful information
References: <OF994D8D1D.24198E91-ONC125711B.00528887-C125711B.0052E575@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 20 Feb 2006 08:55:24 -0800
In-Reply-To: <OF994D8D1D.24198E91-ONC125711B.00528887-C125711B.0052E575@de.ibm.com> (Christoph
 Raisch's message of "Mon, 20 Feb 2006 16:06:19 +0100")
Message-ID: <ada7j7q7ywz.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 20 Feb 2006 16:55:26.0041 (UTC) FILETIME=[7250D490:01C6363E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Christoph> I guess posting 22 new patch files (diff against NIL)
    Christoph> each week is sort of a DoS attack on the mailing list
    Christoph> and we'll end up in peoples spam folders pretty
    Christoph> quickly...  So what's the recomended way to proceed
    Christoph> here?

I don't think there's any other way to proceed.  For each version, you
should carefully note down the feedback that you received and how you
are responding to each suggestion, and include that with the patch
file.  But it's too much to expect for people to keep context for a
patch under review, so even though it generates a lot of email, I
think that including the whole series is the only way to go.

Perhaps the list admins disagree with me though ;)

 - R.
