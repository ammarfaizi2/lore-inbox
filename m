Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030813AbWKOSdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030813AbWKOSdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030815AbWKOSdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:33:40 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:57719 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030813AbWKOSdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:33:38 -0500
Date: Wed, 15 Nov 2006 19:30:49 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, krafft@de.ibm.com
Subject: [patch 0/2] fix bugs while booting on NUMA system where some nodes
 have no mem
Message-ID: <20061115193049.3457b44c@localhost>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches are fixing two problems that showed up
while booting a NUMA system where memory was limited to the first node.
Please cc me for comments as I am not subscribed.

cheers,
Christian

PS: sorry for resending it, I didn't cc myself, and wasn't able to reply to this note.
