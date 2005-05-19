Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVESViy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVESViy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVESViy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:38:54 -0400
Received: from chaos.egr.duke.edu ([152.3.195.82]:645 "EHLO chaos.egr.duke.edu")
	by vger.kernel.org with ESMTP id S261262AbVESVil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:38:41 -0400
Date: Thu, 19 May 2005 17:38:34 -0400 (EDT)
From: Joshua Baker-LePain <jlb17@duke.edu>
X-X-Sender: jlb@chaos.egr.duke.edu
To: Steve Lord <lord@xfs.org>
cc: Lee Revell <rlrevell@joe-job.com>, Gregory Brauer <greg@wildbrain.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Jakob Oestergaard <jakob@unthought.net>, Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
In-Reply-To: <428D05FF.6090305@xfs.org>
Message-ID: <Pine.LNX.4.58.0505191737530.7094@chaos.egr.duke.edu>
References: <428511F8.6020303@wildbrain.com>  <20050514184711.GA27565@taniwha.stupidest.org>
  <428B7D7F.9000107@wildbrain.com>  <20050518175925.GA22738@taniwha.stupidest.org>
  <20050518195251.GY422@unthought.net>  <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
  <428BA8E4.2040108@wildbrain.com>  <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>
  <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu> <1116536963.23186.2.camel@mindpipe>
 <Pine.LNX.4.58.0505191713540.7094@chaos.egr.duke.edu> <428D0540.4000107@xfs.org>
 <428D05FF.6090305@xfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005 at 4:32pm, Steve Lord wrote

> Steve Lord wrote:
> > 
> > Try setting /proc/sys/fs/xfs/error_level to 1 and running again,
> > it should spout out some more information about what it thinks
> > is corrupted.
> > 
> Never mind, you already did that didn't you. I will now go back to
> my day job.....

Actually, I hadn't.  And 'cat /proc/sys/fs/xfs/error_level' says '3'.  Is 
1 more or less verbose?

-- 
Joshua Baker-LePain
Department of Biomedical Engineering
Duke University
