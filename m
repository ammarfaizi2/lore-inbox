Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbTCTPkB>; Thu, 20 Mar 2003 10:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbTCTPkB>; Thu, 20 Mar 2003 10:40:01 -0500
Received: from franka.aracnet.com ([216.99.193.44]:11445 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261528AbTCTPkB>; Thu, 20 Mar 2003 10:40:01 -0500
Date: Thu, 20 Mar 2003 07:50:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Matthew Wilcox <willy@debian.org>
cc: linux-kernel@vger.kernel.org, jes@trained-monkey.org
Subject: Re: [PATCH] Fixup warning for acenic
Message-ID: <7000000.1048175453@[10.10.2.4]>
In-Reply-To: <20030320151754.GB14520@parcelfarce.linux.theplanet.co.uk>
References: <20030320151754.GB14520@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please don't delete this table.  At some point when Jes gets his head
> out of the "must support Linux 1.2" space, this table will be used and
> then this driver will support hotplugging.

Fair enough ... but can we wrap it in CONFIG_SOMETHING? or #if 0 ?

M.

