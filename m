Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUITQiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUITQiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266854AbUITQiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:38:21 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:27092 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S266810AbUITQhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:37:40 -0400
Date: Mon, 20 Sep 2004 18:37:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 patches for -bk.
Message-ID: <20040920163727.GA3092@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
three patches for -bk. The first one removes invoke_softirq from s390.
It was introduced for s390, so we might consider removing it again.
The rest is small bug fixes.

blue skies,
  Martin.
