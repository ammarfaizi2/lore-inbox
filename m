Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTIFQuj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 12:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbTIFQuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 12:50:39 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23309
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261305AbTIFQui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 12:50:38 -0400
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
From: Robert Love <rml@tech9.net>
To: John Yau <jyau_kernel_dev@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Law12-F124jgZ3Vxq7b00024eb1@hotmail.com>
References: <Law12-F124jgZ3Vxq7b00024eb1@hotmail.com>
Content-Type: text/plain
Message-Id: <1062867675.3754.0.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sat, 06 Sep 2003 13:01:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-06 at 05:46, John Yau wrote:

> I'm new to patch submission process, so bear with me.  This little patch I 
> wrote seems to get rid of the annoying skipping in xmms except in the most 
> extreme cases.  See comments inlined in code for details of the fix.

This looks exactly like the granular timeslice patch Ingo did?

	Robert Love


