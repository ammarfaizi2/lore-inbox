Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWFSRPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWFSRPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWFSRPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:15:47 -0400
Received: from bambus1.net.skarpam.net ([83.142.194.78]:51083 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S964781AbWFSRPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:15:47 -0400
Date: Mon, 19 Jun 2006 19:15:44 +0200
From: Piotr Kaczuba <pepe@attika.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: [x86_64] PC speaker doesn't work
Message-ID: <20060619171544.GA4363@attika.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

With 2.6.17 the PC speaker stopped working (2.6.16.20 was fine). The
module pcspkr is loaded but dmesg doesn't show that it gets registered
as 2.6.16 did:

input: PC Speaker as /class/input/input2

I saw a thread about the speaker issue a while ago in which a patch
was posted that made it into 2.6.17 but somehow it doesn't seem
to be enough. Am I missing something?

I'm running x86-64 kernel with 32-bit userspace if that should matter.

Please CC me as I'm not subscribed.

Piotr Kaczuba
