Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVAXGO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVAXGO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVAXGO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:14:28 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261447AbVAXGO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:26 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][0/12] InfiniBand: updates for 2.6.11-rc2
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:23 -0800
Message-Id: <20051232214.Ndv3rt3gl8fJimFA@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:24.0918 (UTC) FILETIME=[F3C53360:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are updates since the last merge of drivers/infiniband taken from
the OpenIB repository.  A couple small fixes, the addition of "issm"
device support to allow userspace to set the IsSM port capability bit,
and a bunch of mthca driver improvements.  There shouldn't be anything
risky (and it's all confined to drivers/infiniband).

Thanks,
  Roland

