Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUKQXFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUKQXFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbUKQXDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:03:50 -0500
Received: from smtp06.web.de ([217.72.192.224]:42682 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S262585AbUKQXBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:01:54 -0500
Date: Thu, 18 Nov 2004 00:12:14 +0100
From: Hanno Meyer-Thurow <h.mth@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc2-mm1] OOPS on boot (hotplug related?)
Message-Id: <20041118001214.6556b798.h.mth@web.de>
X-Mailer: Sylpheed version 1.0.0beta2-gtk2-20041110 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian Axelsson,

I get that hotplug oops on 2.6.10-rc2-bk1/2 but not on 2.6.10-rc2. so that bug must be in latest bk1 patchset. For anyone interested in bugfixing see my foto at:

http://geki.ath.cx/hotplug-oops.jpg
