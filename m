Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965276AbWJBS30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbWJBS30 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWJBS3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:29:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3021 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965276AbWJBS3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:29:24 -0400
Date: Mon, 2 Oct 2006 11:28:57 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] usb hubc build fix.patch prefix
Message-Id: <20061002112857.dc955603.pj@sgi.com>
In-Reply-To: <20061002111223.1e5943dc.akpm@osdl.org>
References: <20061002023720.9780.85391.sendpatchset@v0>
	<Pine.LNX.4.44L0.0610021003330.6651-100000@iolanthe.rowland.org>
	<20061002092737.7816b8f5.pj@sgi.com>
	<20061002111223.1e5943dc.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> I screwed things up and attempted to fix things by hand post-release and ...

Aha.  Looks like we found the culprit ;).

Sounds like you're on it.  Good.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
