Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWJJNUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWJJNUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWJJNUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:20:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34224 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750733AbWJJNUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:20:52 -0400
Subject: Re: [Cluster-devel] [2.6 patch] Kconfig: don't show an empty DLM
	menu
From: Steven Whitehouse <swhiteho@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, pcaulfie@redhat.com, teigland@redhat.com,
       cluster-devel@redhat.com, Dmytro Bagrii <dmb@pochta.ru>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061008023048.GD29474@stusta.de>
References: <20061008023048.GD29474@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 10 Oct 2006 14:24:02 +0100
Message-Id: <1160486642.11901.773.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2006-10-08 at 04:30 +0200, Adrian Bunk wrote:
> Don't show an empty "Distributed Lock Manager" menu if IP_SCTP=n.
> 
> Reported by Dmytro Bagrii in kernel Bugzilla #7268.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
I just spotted this patch. Sorry I didn't see it earlier, not sure what
happened there, but its now in the gfs2 git tree. Thanks,

Steve.


