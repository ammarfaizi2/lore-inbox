Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWF0Ex5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWF0Ex5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933422AbWF0ElT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:19 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:34779 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933408AbWF0Ek0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:26 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 14:40:25 +1000
Subject: [Suspend2][ 00/13] Storage manager.
Message-Id: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The storage manager provides a way for a userspace helper to bring
up and tear down access to storage, as necessary. The helper must
not itself need external programs, but can perform actions such as
bringing up access to networked storage.
