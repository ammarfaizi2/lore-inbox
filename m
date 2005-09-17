Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVIQRQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVIQRQm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 13:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVIQRQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 13:16:41 -0400
Received: from khc.piap.pl ([195.187.100.11]:4100 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751162AbVIQRQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 13:16:41 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Why don't we separate menuconfig from the kernel?
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 17 Sep 2005 19:16:33 +0200
Message-ID: <m364szk426.fsf@defiant.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A number of packages (e.g., busybox) use some, more or less broken,
version of menuconfig. Would it make sense to move menuconfig to
a separate well-defined package?

Nooo? Why not?
-- 
Krzysztof Halasa
