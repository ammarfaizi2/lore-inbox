Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTFKAW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTFKAW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:22:28 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45280 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262283AbTFKAV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:21:56 -0400
Date: Tue, 10 Jun 2003 17:36:38 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: hannal@us.ibm.com
Subject: [2.4.21-rc8] Lockmeter port available
Message-ID: <108460000.1055291798@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As part of my testing of the fastwalk patch I ported the lockmeter
patch that John Hawkes wrote to 2.4.21-rc8. This patch now applied
cleanly, there were minimal merge conflicts I fixed for the i386 arch.
This allows you to see which functions are contending for which locks,
among other great things.

Available on Sourceforge at:

http://osdn.dl.sourceforge.net/sourceforge/lse/lockmeter1.5-2.4.21-rc8.diff

Hanna 

