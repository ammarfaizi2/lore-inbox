Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVAVBqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVAVBqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 20:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVAVBqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 20:46:36 -0500
Received: from main.gmane.org ([80.91.229.2]:19375 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262394AbVAVBpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 20:45:44 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dan Stromberg <strombrg@dcs.nac.uci.edu>
Subject: Loopback mounting from a file with a partition table?
Date: Fri, 21 Jan 2005 17:45:32 -0800
Message-ID: <pan.2005.01.22.01.45.31.457367@dcs.nac.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: seki.nac.uci.edu
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone tried loopback mounting individual partitions from within a
file that contains a partition table?

When I mount -o loop the file, I seem to get the first partition in the
file, but I don't see anything in the man page for mount that indicates a
way of getting any other partitions from a file with a partition table.

Any comments?

Thanks!


