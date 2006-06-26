Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933153AbWFZXfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153AbWFZXfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933151AbWFZWes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:48 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:27551 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933117AbWFZWeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:14 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 08:34:12 +1000
Subject: [Suspend2][ 0/9] Pagedir specific routines.
Message-Id: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Routines used in the allocation of extra memory for atomic
copies, calculating which pages belong in each part of the
image and finding usable pages when resuming.
