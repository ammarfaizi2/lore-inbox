Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269157AbUHZP6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269157AbUHZP6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269143AbUHZP5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:57:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:30109 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269113AbUHZPzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:55:37 -0400
Subject: Re: [RFC] buddy allocator without bitmap [4/4]
From: Dave Hansen <haveblue@us.ibm.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <412DD452.1090703@jp.fujitsu.com>
References: <412DD452.1090703@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1093535690.2984.22.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 08:54:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 05:15, Hiroyuki KAMEZAWA wrote:
> This patch 5th inserts prefetch().
> I think These prefetch are reasonable and helpful.

Do you have any benchmark numbers to show it?

-- Dave

