Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVBRUx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVBRUx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVBRUx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:53:57 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:45852 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261501AbVBRUwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:52:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=uMmhqgYpi6gkAhuqAlbUp/OzsSEX8oPDABnveySkeaoOUGowlOB1IgcEtf2Ffqf1M06avBf5HyZbsRcW/S1zDpxPY1vXL3fTCxUpnEvIYcSxWJCqAPHd/kLtLx8WP+RYl6QdUKjGEOBN5APfBQEaY3eLIQnqysxCbpXVtbkDXLA=
Message-ID: <9e4733910502181251ea2b95e@mail.gmail.com>
Date: Fri, 18 Feb 2005 15:51:58 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
Subject: Hotplug blacklist and video devices
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why are all of the framebuffer drivers on the hotplug blacklist?

-- 
Jon Smirl
jonsmirl@gmail.com
