Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263894AbRFNSb6>; Thu, 14 Jun 2001 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263909AbRFNSbb>; Thu, 14 Jun 2001 14:31:31 -0400
Received: from mail.fluke.com ([129.196.128.53]:51216 "EHLO
	evtvir03.tc.fluke.com") by vger.kernel.org with ESMTP
	id <S263894AbRFNSaq>; Thu, 14 Jun 2001 14:30:46 -0400
Date: Thu, 14 Jun 2001 11:30:53 -0700 (PDT)
From: David Dyck <dcd@tc.fluke.com>
To: Jacques Gelinas <jacques@solucorp.qc.ca>, Bjorn Ekwall <bj0rn@blox.se>
cc: <linux-kernel@vger.kernel.org>
Subject: linux Documentation/modules.txt
Message-ID: <Pine.LNX.4.33.0106141050090.1427-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just noticed that file "rc.hints" mentioned in modules.txt
does not exist anywhere in the module utilities package.
I looked in modutils-2.4.2 as documented in Changes.

If rc.hints really doesn't exist, perhaps the sentence in
parenthesis should be removed, since it doesn't assist the reader.

The following text is from modules.txt:
To use modprobe successfully, you generally place the following
command in your /etc/rc.d/rc.S script.  (Read more about this in the
"rc.hints" file in the module utilities package, "modutils-x.y.z.tar.gz".)

