Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272748AbTHPLE4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272756AbTHPLE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:04:56 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:47070
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S272748AbTHPLEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:04:55 -0400
Date: Sat, 16 Aug 2003 13:07:35 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O16.2int
Message-Id: <20030816130735.3ec67ac9.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-08-16 8:59:48 Con Kolivas wrote:

> Much simpler

For a coder, perhaps. This user however is facing what feels like a
fundamental flaw. The doubling of boot time was fixed, but game-test is
pretty much as it was in pure O16 (impossible) and Blender is equally
bad - now even the mouse pointer vanishes, becomes invisible, during the
10+ second pauses. And it is with Blender as only app running. Didn't
dare to start xmms...

I'll keep running the 2.6.0-test3 ---> O16.2int though. Might pick up
other cases of regression in lighter usage.

Mvh
Mats Johannesson
