Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030178AbWHYOtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbWHYOtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWHYOtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:49:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51840 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030178AbWHYOtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:49:21 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 00/18] BLOCK: Permit block layer to be disabled [try #3]
Date: Fri, 25 Aug 2006 15:49:16 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches permits the block layer to be disabled and removed from
the compilation such that it doesn't take up any resources on systems that
don't need it.

This set of patches is against the block git tree.

David
