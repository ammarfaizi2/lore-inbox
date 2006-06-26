Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933163AbWFZWgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933163AbWFZWgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933172AbWFZWgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:09 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:43423 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933178AbWFZWf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:59 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 08:35:57 +1000
Subject: [Suspend2][ 00/19] Highlevel I/O routines.
Message-Id: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add the core's routines for doing I/O. These are the high
level routines for reading and writing the image proper
and header.
