Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTFDPUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTFDPUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:20:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:28880 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263455AbTFDPUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:20:50 -0400
Subject: Re: 2.5.70-mm4
From: Paul Larson <plars@linuxtestproject.org>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20030603231827.0e635332.akpm@digeo.com>
References: <20030603231827.0e635332.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Jun 2003 10:33:40 -0500
Message-Id: <1054740832.8244.159.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 01:18, Andrew Morton wrote:

> . A patch which adds the statfs64() syscall.  This involved some mangling
>   of the BSD accountig code.  If anyone knows how to test BSD accounting,
>   please do so, or let me know.
For what it's worth, LTP has two BSD acct tests and they both pass
fine.  These are not elaborate or stressful in anyway, but they make for
a good, quick sniff test.

Thanks,
Paul Larson


