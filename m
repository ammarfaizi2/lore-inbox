Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTDWQ7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTDWQ7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:59:13 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:60433
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264144AbTDWQ7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:59:12 -0400
Subject: Re: 2.5.68-mm2
From: Robert Love <rml@tech9.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1509100000.1051117049@flay>
References: <20030423012046.0535e4fd.akpm@digeo.com>
	 <20030423095926.GJ8931@holomorphy.com> <1051116646.2756.2.camel@localhost>
	 <1509100000.1051117049@flay>
Content-Type: text/plain
Message-Id: <1051117874.2756.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 23 Apr 2003 13:11:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 12:57, Martin J. Bligh wrote:

> Is this the bug that akpm was seeing, or a different one? The only 
> information I've seen (indirectly) is that fsx triggers the oops.

I cannot see this cause an oops, so no.

Just out-of-sync values resulting in an unexpected OOM or a delayed OOM.

	Robert Love

