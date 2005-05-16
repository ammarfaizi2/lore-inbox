Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVEPH3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVEPH3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 03:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVEPH0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 03:26:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3281 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261424AbVEPHPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:15:53 -0400
Date: Mon, 16 May 2005 15:19:49 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-cluster@redhat.com
Subject: [PATCH 0/8] dlm: overview
Message-ID: <20050516071949.GE7094@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the distributed lock manager (dlm) patches against 2.6.12-rc4
that we'd like to see added to the kernel.  We've made changes based on
the suggestions that were sent, and are happy to get more, of course.

The original overview
http://marc.theaimsgroup.com/?l=linux-kernel&m=111444188703106&w=2

For those interested in performance, there is some information here
http://sources.redhat.com/cluster/dlm/

Dave

