Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264964AbTLWHDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 02:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTLWHDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 02:03:05 -0500
Received: from mail.mediaways.net ([193.189.224.113]:51649 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S264964AbTLWHDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 02:03:03 -0500
Subject: 2.6.0ben1 + ieee1394 (snapshot from yesterdays svn repos) -> works
From: Soeren Sonnenburg <kernel@nn7.de>
To: bcollins@debian.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1072162924.2803.462.camel@localhost>
Mime-Version: 1.0
Date: Tue, 23 Dec 2003 08:02:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I just wanted to send kudos, as this version seems to be the first one
which does not generate a kernel panik just from the very start. It was
also possible to transfer ~20GB (firewire attached ide-hd) via the sbp2
module and then removing the sbp2/ohci1394/ieee1394 module several times
without it oopsing (that was enough last time I checked to generate a
kernel panik!)

Regards,
Soeren.

