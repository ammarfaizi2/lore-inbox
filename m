Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUAJDoy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 22:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUAJDoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 22:44:54 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:59086 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264920AbUAJDox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 22:44:53 -0500
From: eternalblue@t-online.de (eternalblue)
Organization: Universe
To: linux-kernel@vger.kernel.org
Subject: BUG:2.6.1 USB keyboard ignores "#" key
Date: Sat, 10 Jan 2004 04:45:26 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401100445.26797.eternalblue@t-online.de>
X-Seen: false
X-ID: S9WggwZDYeGyCP3edfnNNFbZzqY1RYelHsSj2aEUaJmYGz36ydaQ0+
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I verified that this bug has appeared in 2.6.1.
Having updated from .0 to .1 i lost my "#" key. My keyboard is a German USB 
Keyboard (Logitech Cordless).
This bug has been reported on the gentoo forums as well!
Switching back to 2.6.0 fixed the problem => 2.6.0 doesnt have this bug!

Greetings,

Florian

