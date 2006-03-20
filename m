Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWCTQQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWCTQQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbWCTQQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:16:39 -0500
Received: from ip-68-128.sn2.eutelia.it ([83.211.68.128]:3424 "EHLO
	linserver.ds4.is.it") by vger.kernel.org with ESMTP id S964930AbWCTQQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:16:36 -0500
Subject: inter-module-put/get replacement
From: Giampaolo Bellini <giampaolobellini@ds4.it>
To: linux-kernel@vger.kernel.org
Cc: giampaolobellini@ds4.it
Content-Type: text/plain
Organization: DS4 Laser Technology srl
Message-Id: <1142871376.4032.12.camel@Giampaolo>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Mar 2006 17:16:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

  looking at intermodule.c I found that inter-modules functions are
marked as deprecated in 2.6 kernel... are there replacements ? How can I
extend the functionality of a module without these functions ?

  thanks,

          Giampaolo



