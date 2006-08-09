Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWHIQ5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWHIQ5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWHIQ5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:57:34 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:34434 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750876AbWHIQ5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:57:33 -0400
Subject: [PATCH 0/6] read-only bind mount prep work
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 09 Aug 2006 09:57:29 -0700
Message-Id: <20060809165729.FE36B262@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches lay some of the groundwork for the
read-only bind mounts.  Christoph Hellwig suggested that
I send them in separately.  This was a good suggestion,
as the bulk of the modifications of the entire set happen
in here, and these should make no functional changes, and
should be pretty easy to merge.

-- Dave
