Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936981AbWLDPqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936981AbWLDPqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937026AbWLDPqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:46:05 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:33704 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936981AbWLDPqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:46:03 -0500
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Steve Wise <swise@opengridcomputing.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 04/13] Connection Manager
X-Message-Flag: Warning: May contain useful information
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	<20061202224958.27014.65970.stgit@dell3.ogc.int>
	<20061204110825.GA26251@2ka.mipt.ru>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 04 Dec 2006 07:45:52 -0800
In-Reply-To: <20061204110825.GA26251@2ka.mipt.ru> (Evgeniy Polyakov's message of "Mon, 4 Dec 2006 14:08:26 +0300")
Message-ID: <ada8xhnk6kv.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Dec 2006 15:45:52.0868 (UTC) FILETIME=[47776A40:01C717BB]
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Could you convince network core developers that it is not own TCP
 > implementation which will mess with existing one?

I'm not qualified to comment on this...

 > This and a lot of other changes in this driver definitely says you
 > implement your own stack of protocols on top of infiniband hardware.

...but I do know this driver is for 10-gig ethernet HW.

 - R.
