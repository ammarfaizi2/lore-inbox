Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbTHVTLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264179AbTHVTLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:11:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19094 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264165AbTHVTLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:11:50 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
Date: Fri, 22 Aug 2003 14:11:03 -0500
User-Agent: KMail/1.5
Cc: Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
References: <200308201658.05433.habanero@us.ibm.com> <200308211202.02871.habanero@us.ibm.com> <20030822171625.GM4306@holomorphy.com>
In-Reply-To: <20030822171625.GM4306@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308221411.03767.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 August 2003 12:16, William Lee Irwin III wrote:
> On Thu, Aug 21, 2003 at 12:02:02PM -0500, Andrew Theurer wrote:
> > Boot log with extra kicked++ removed...
>
> Say, could you try last night's bk snapshot and let me know how it's
> doing? I threw in a necessary fix on top of Dave's last night, but I
> don't know whether it's sufficient for your purposes yet.

OK, looks like it worked fine.

