Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751919AbWCAVXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWCAVXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWCAVXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:23:34 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:24045
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751919AbWCAVXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:23:33 -0500
Message-ID: <440610DA.30001@ed-soft.at>
Date: Wed, 01 Mar 2006 22:23:38 +0100
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.6.16-rc5 does not boot on Intel Core Duo
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.16-rc5 does not boot on Intel Core Duo CPU's.
The kernel does not reach start_kernel in head.S

cu

Edgar (gimli) Hucek
