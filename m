Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266380AbUFUSYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266380AbUFUSYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 14:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266382AbUFUSYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 14:24:37 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:36034 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S266380AbUFUSYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 14:24:36 -0400
Message-ID: <40D98C72.3040807@myrealbox.com>
Date: Wed, 23 Jun 2004 06:58:10 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040622
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.7-bk] NFS-related kernel panic
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting just today with the latest bk changesets I get a kernel
panic when starting the rpc.statd daemon (NFS):

Kernel panic:  Aiee, killing interrupt handler
In interrupt handler - not syncing

Anyone else seeing problems with NFS?
