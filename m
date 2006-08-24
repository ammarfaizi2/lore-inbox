Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422729AbWHXVgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWHXVgk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422711AbWHXVdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:33:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25572 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422704AbWHXVdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:33:32 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/17] BLOCK: Stop CIFS from using EXT2 ioctl numbers directly [try #2]
Date: Thu, 24 Aug 2006 22:33:30 +0100
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com
Message-Id: <20060824213330.21323.88530.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Stop CIFS from using EXT2 ioctl numbers directly, making it use the ones in
linux/fs.h instead.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 0 files changed, 0 insertions(+), 0 deletions(-)
