Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbTD1WCI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 18:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTD1WCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 18:02:08 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:27373 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261333AbTD1WCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 18:02:08 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: torvalds@transmeta.com
Subject: PATCH: Replace current->state with set_current_state in 2.5.68  
Date: Mon, 28 Apr 2003 18:17:32 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304281817.32397.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appies to 2.5.68 and replaces any remaining current->state lines 
 with set_current_state. This from the TODO list of Kernel Janitors.

http://muss.mcmaster.ca/~devenyga/patch-linux-2.5.68-set_current_state.patch
 
Please CC me with any discussion since I do not subscribe to the kernel-list.
-- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca
