Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVEIVEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVEIVEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVEIVEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:04:07 -0400
Received: from mail.tyan.com ([66.122.195.4]:53770 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261516AbVEIVEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:04:06 -0400
Message-ID: <3174569B9743D511922F00A0C943142309B0816F@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: YhLu <YhLu@tyan.com>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: x86-64 dual core mapping
Date: Mon, 9 May 2005 14:24:50 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

the dual core mapping in 2.6.12-rc4 is not right yet. you may need to try
"acpi=off"

YH 
