Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVESVv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVESVv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVESVv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:51:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34540 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261281AbVESVtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:49:32 -0400
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
From: Lee Revell <rlrevell@joe-job.com>
To: Joshua Baker-LePain <jlb17@duke.edu>
Cc: Gregory Brauer <greg@wildbrain.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Jakob Oestergaard <jakob@unthought.net>,
       Chris Wedgwood <cw@f00f.org>
In-Reply-To: <Pine.LNX.4.58.0505191740550.7094@chaos.egr.duke.edu>
References: <428511F8.6020303@wildbrain.com>
	 <20050514184711.GA27565@taniwha.stupidest.org>
	 <428B7D7F.9000107@wildbrain.com>
	 <20050518175925.GA22738@taniwha.stupidest.org>
	 <20050518195251.GY422@unthought.net>
	 <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
	 <428BA8E4.2040108@wildbrain.com>
	 <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>
	 <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu>
	 <Pine.LNX.4.58.0505191740550.7094@chaos.egr.duke.edu>
Content-Type: text/plain
Date: Thu, 19 May 2005 17:49:30 -0400
Message-Id: <1116539371.23186.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 17:42 -0400, Joshua Baker-LePain wrote:
> And now I've got some OOPSes:

Did these come after the Oops you first posted, or had you rebooted
since?

If you have not rebooted since the previous Oops, then these are not
useful.

Lee

