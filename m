Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266064AbUBCRNr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 12:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUBCRNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 12:13:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32210 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266039AbUBCRNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 12:13:45 -0500
Date: Tue, 3 Feb 2004 12:13:34 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Clay Haapala <chaapala@cisco.com>
cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, <mpm@selenic.com>
Subject: Re: [PATCH 2.6.1] Add CRC32C chksums to crypto and lib routines
In-Reply-To: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com>
Message-ID: <Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, Clay Haapala wrote:

The patch looks malformed:

+/*
+ * This function will XOR the results with ~0, so take that into
+ * account.
+ */
+static inline void c



- James
-- 
James Morris
<jmorris@redhat.com>


