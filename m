Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030662AbWF0FHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030662AbWF0FHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030685AbWF0FG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:06:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:25051 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030662AbWF0EjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:24 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 14:39:23 +1000
Subject: [Suspend2][ 00/13] Generic netlink support.
Message-Id: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Routines used by both the user interface code and storage manager
to interface with userspace programs through netlink sockets.
