Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUCPSc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUCPSc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:32:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:59079 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261225AbUCPScy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:32:54 -0500
Subject: Re: 2.6.4-mm2
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040314172809.31bd72f7.akpm@osdl.org>
References: <20040314172809.31bd72f7.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Mar 2004 10:32:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I re-ran six copies of the direct_read_under test on an 8-proc
machine last night.  All six tests saw uninitialized data.


Daniel

