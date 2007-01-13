Return-Path: <linux-kernel-owner+w=401wt.eu-S1750952AbXAMXv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbXAMXv0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbXAMXv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:51:26 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40561 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbXAMXvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:51:25 -0500
Message-ID: <45A97089.5090004@drzeus.cx>
Date: Sun, 14 Jan 2007 00:51:37 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: No more "device" symlinks for classes
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I just wanted to know the rationale behind
99ef3ef8d5f2f5b5312627127ad63df27c0d0d05 (no more "device" symlink in
class devices). I thought that was a rather convenient way of finding
which physical device the class device was coupled to.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
