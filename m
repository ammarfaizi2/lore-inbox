Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTJZK1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 05:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbTJZK1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 05:27:08 -0500
Received: from hera.cwi.nl ([192.16.191.8]:22170 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262772AbTJZK1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 05:27:04 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 26 Oct 2003 11:26:49 +0100 (MET)
Message-Id: <UTC200310261026.h9QAQn404637.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hirofumi@mail.parknet.co.jp
Subject: Re: Linux 2.6.0-test9
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

    Andries.Brouwer@cwi.nl writes:

    > Within a few days two people have reported that they cannot
    > mount a FAT fs that 2.4 and Windows handle fine.
    > Probably also that should be fixed, for example with
    > my patch from yesterday.

    Was the other report by private email?

Yes. Mark McPherson wrote:

  I have an Archos Jukebox Recorder 20 which has never been
  re-formatted since I purchased it.  It fails to mount under 2.6 with
  the same report as the flash card, and also mounts successfully under 2.4.
  Patching around the code as you suggested allows it to mount without
  complaint under 2.6.
  Win2K thinks this file system is just fine.

Andries


