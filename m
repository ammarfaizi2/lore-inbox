Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbUAKLjU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 06:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbUAKLjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 06:39:20 -0500
Received: from 015.atlasinternet.net ([212.9.93.15]:51665 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S265834AbUAKLjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 06:39:19 -0500
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-mm1: A couple of problems
Date: Sun, 11 Jan 2004 12:39:15 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401111239.15445.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, just a copule of problems with kernel 2.6.1-mm1

- artsd running with ALSA gives the error: "CPU overloading, stopping" 
just few seconds after it began to play a song. It's a P4 HT with SMP 
enabled.

- Xfree hang: in a Dell Latitude laptop (P3-M 933), xfree (4.3, last 
version in Debian experimental) hangs and shows a white screen. The 
keyboard is also blocked, but login from the network is still OK. There 
is no any error message. I also see the same effect when I tryed to run 
Xine in full screen mode.

Hope this helps.

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

