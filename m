Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbUJ3SOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUJ3SOM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUJ3SJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:09:19 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:1552 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S261265AbUJ3SIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:08:36 -0400
Message-ID: <4183D8A3.1050709@superbug.co.uk>
Date: Sat, 30 Oct 2004 19:08:35 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel <linux-kernel@vger.kernel.org>
Subject: Linux multicast IGMPv3 and PIM-SM
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to turn a Linux box into a Multicast router running IGMPv3 and 
PIM-Sparse-Mode.

I have only managed to find linux support for Multicast host mode.
I.e. support for a Multicast Client application.

Is there any support for turning linux into a multicast router.
I have looked at mrouted, but it does not support IGMPv3. It only 
supports IGMPv1/2.

Kind regards

James.
