Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWCCWxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWCCWxR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWCCWxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:53:17 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:3722 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932070AbWCCWxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:53:16 -0500
X-IronPort-AV: i="4.02,163,1139212800"; 
   d="scan'208"; a="1781796507:sNHT31037740"
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: [openib-general] [PATCH 0/5] Infiniband: connection abstraction
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX4011XvpFVjCRG00000015@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 03 Mar 2006 14:53:06 -0800
In-Reply-To: <ORSMSX4011XvpFVjCRG00000015@orsmsx401.amr.corp.intel.com> (Sean Hefty's message of "Fri, 3 Mar 2006 13:13:23 -0800")
Message-ID: <adaslpz2l9p.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Mar 2006 22:53:11.0808 (UTC) FILETIME=[3F743000:01C63F15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sean> I can resubmit the patches if necessary.

Yes, can you please send out the patches again, with descriptive
subjects for each patch and with the ip_dev_find() re-export split
into its own patch?  That would make it easier for me to pull into my
git tree.

Thanks,
  Roland
