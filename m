Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVAMBS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVAMBS1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVAMBRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:17:11 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261412AbVALVr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:47:57 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:47:38 -0800
Message-Id: <20051121347.unEev2HOanwhx9cL@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][0/18] InfiniBand: updates for 2.6.11-rc1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:47:44.0344 (UTC) FILETIME=[59127D80:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are updates since the initial merge to drivers/infiniband taken
from the OpenIB repository.  This is a mix of cleanups, bug fixes and
small features.  There shouldn't be anything controversial or risky.

Thanks,
  Roland

