Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWHBQyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWHBQyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWHBQyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:54:33 -0400
Received: from main.gmane.org ([80.91.229.2]:42457 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751235AbWHBQyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:54:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Steve Fox <drfickle@us.ibm.com>
Subject: Re: [PATCH] fix vmstat per cpu usage
Date: Wed, 02 Aug 2006 11:54:08 -0500
Organization: IBM
Message-ID: <pan.2006.08.02.16.54.06.340644@us.ibm.com>
References: <20060801173620.GM4995@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: rchp4.rochester.ibm.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006 19:36:21 +0200, Jan Blunck wrote:

> From: Jan Blunck <jblunck@suse.de>
> Subject: fix vmstat per cpu usage
> 
> The per cpu variables are used incorrectly in vmstat.h.
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>

This patch has allowed the first 2.6.18-rc* successful compilation on s390.

Andrew, please pull this into your tree too. Thanks.

Acked-by: Steve Fox <drfickle@us.ibm.com>

-- 

Steve Fox
IBM Linux Technology Center


