Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWI2KTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWI2KTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 06:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWI2KTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 06:19:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53739 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750896AbWI2KS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 06:18:59 -0400
Date: Fri, 29 Sep 2006 11:18:26 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: John Stoffel <john@stoffel.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ishai Rabinovitz <ishai@mellanox.co.il>
Subject: Re: [PATCH 01/25] dm: fix alloc_dev error path
Message-ID: <20060929101826.GS17654@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	John Stoffel <john@stoffel.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Ishai Rabinovitz <ishai@mellanox.co.il>
References: <20060914213653.GI3928@agk.surrey.redhat.com> <17674.48795.392953.993935@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17674.48795.392953.993935@smtp.charter.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 10:54:19AM -0400, John Stoffel wrote:
> So how come these patches aren't also posted to the linux-lvm mailing
> list as well?  
 
device-mapper patches are discussed on the dm-devel mailing list.

We have discussed the usage of the various mailing lists at the
device-mapper/lvm2 summit here in Germany this week and one decision 
was always to Cc:dm-devel on such patches at submission stage in
future.  (Usually they been on that list already, prior to submission.)

Alasdair
-- 
agk@redhat.com
