Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbUAJKi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 05:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUAJKi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 05:38:27 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:24899 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S263622AbUAJKi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 05:38:26 -0500
Message-ID: <3FFFD61C.7070706@samwel.tk>
Date: Sat, 10 Jan 2004 11:38:20 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dax Kelson <dax@gurulabs.com>, Kiko Piris <kernel@pirispons.net>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
Subject: [PATCH] Laptop-mode v7 for linux 2.6.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've created a new version of the laptop-mode patch, this time against 
linux 2.6.1. It can be found here:

http://www.liacs.nl/~bsamwel/laptop_mode/laptop-mode-2.6.1-7.patch

It has no kernel code changes, only changes to the supporting 
documentation/scripts:

* Dax Kelson's ACPI integration script is included.
* Fixed a missing "esac" in the control script.
* Minor documentation improvements.

Especially Dax's addition should make it a lot more usable. I haven't 
been able to test this myself however, because I don't own a laptop. Dax 
probably does, so I'll trust him and assume that he has tested it. ;)

-- Bart
