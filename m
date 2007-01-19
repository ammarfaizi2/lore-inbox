Return-Path: <linux-kernel-owner+w=401wt.eu-S932600AbXASRIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXASRIJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbXASRIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:08:09 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:36689 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600AbXASRIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:08:07 -0500
To: Steve Wise <swise@opengridcomputing.com>
Cc: openib-general <openib-general@openib.org>, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [Fwd: Re: [PATCH 1/10] cxgb3 - main header files]
X-Message-Flag: Warning: May contain useful information
References: <1169216896.15842.6.camel@stevo-desktop>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 19 Jan 2007 09:07:57 -0800
In-Reply-To: <1169216896.15842.6.camel@stevo-desktop> (Steve Wise's message of "Fri, 19 Jan 2007 08:28:16 -0600")
Message-ID: <adamz4f0wsy.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 Jan 2007 17:07:57.0797 (UTC) FILETIME=[5DF47150:01C73BEC]
Authentication-Results: sj-dkim-6; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim6002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Jeff has pulled in the Chelsio Ethernet driver.  If you are ready to
 > merge in the RDMA driver, you can pull it from 

Yes, I saw that... OK, I'll get serious about reviewing the RDMA stuff.
