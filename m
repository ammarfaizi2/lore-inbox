Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTD2WE4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbTD2WE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:04:56 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:45522 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261309AbTD2WEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:04:55 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] KernelJanitor: Convert remaining error returns to return -E Linux 2.5.68
Date: Tue, 29 Apr 2003 22:15:20 +0000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304292215.20590.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies to 2.5.68. It converts all the remaining error returns to 
the new return -E form, this is in the KernelJanitor TODO list.

http://muss.mcmaster.ca/~devenyga/patch-linux-2.5.68-return-errors.patch

Please CC me with any discussion since I do not subscribe to lkml
-- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca
