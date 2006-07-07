Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWGGViW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWGGViW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWGGViW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:38:22 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:7353 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932296AbWGGViV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:38:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: bmap question (probably stupid)
Date: Fri, 7 Jul 2006 23:38:55 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607072338.55379.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to use something like bmap() from the user space.  I've found the
BMAP_IOCTL, but it's marked as obsolete, so my question is what's the
recommended way of doing this?

Thanks in advance,
Rafael
