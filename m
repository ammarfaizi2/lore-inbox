Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWIWUnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWIWUnn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWIWUnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:43:43 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:51302 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964850AbWIWUnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:43:41 -0400
In-Reply-To: <adahcyzfkd0.fsf@cisco.com>
Subject: Re: [PATCH 2.6.19-rc1] ehca firmware interface based on Anton Blanchard's
 new hvcall interface
To: Roland Dreier <rdreier@cisco.com>
Cc: "Christoph.Raisch/Germany/IBM" 
	<Christoph.Raisch/Germany/IBM@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org, pmac@au1.ibm.com,
       rolandd@cisco.com
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OFFF711B0A.758C0571-ONC12571F2.0070BAD2-C12571F2.0071ED80@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Sat, 23 Sep 2006 22:45:28 +0200
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 23/09/2006 22:45:31
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland,
> Anyway both Paul and I merged with Linus today, so the hcall cleanup
> and ehca are both upstream.  It would be great if you could do a quick
> check to make sure that ehca works in Linus's current git tree.
I compiled Linus's git tree and did some basic tests successfully
with ehca (ipoib, userspace, netpipe tcp/ib).
Thanks!
Nam Nguyen

