Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265878AbUFXWzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUFXWzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264727AbUFXWzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:55:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45505 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265792AbUFXWxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:53:54 -0400
Date: Thu, 24 Jun 2004 17:53:49 -0500
From: Ken Preslan <kpreslan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: GFS cluster filesystem re-released
Message-ID: <20040624225349.GA12796@potassium.msp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to announce that Red Hat has re-released the GFS cluster
filesystem and its related infrastructure under the GPL.  The
different projects that make up the infrastructure are:

GFS - shared-disk cluster file system
CLVM - clustering extensions to the LVM2 logical volume manager toolset
CMAN - general-purpose symmetric cluster manager
DLM - general-purpose distributed lock manager
CCS - cluster configuration system to manage the cluster config file
GULM - alternative redundant server-based lock/cluster manager for GFS
GNBD - network block device driver shares storage over a network
Fence - I/O fencing system

The source code and patches for 2.6 are available at
http://sources.redhat.com/cluster/.  2.4 source should show up early
tomorrow.

We're looking for people help us work on this project so we can
eventually get it included into the Linux kernel.  Comments,
suggestions, patches, and testers are more than welcome.

Thanks.

-- 
Ken Preslan <kpreslan@redhat.com>

