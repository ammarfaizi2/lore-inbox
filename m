Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTKBBL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 20:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTKBBL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 20:11:56 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:28168 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261299AbTKBBLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 20:11:55 -0500
Date: Sun, 2 Nov 2003 02:09:33 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: CD-recorder problem
Message-ID: <20031102010933.GA206@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I've a Plextor Premium CD-Writer, ATAPI, and I'm experiencing
problems with it. The problem is that everytime I write at more than
8x (data, I mean), the disc has errors, but neither cdrecord nor the
kernel reports them during the writing process. The errors are a few
bits on an entire CD, but anyway those little error render the copy
unusable. Under 8x the writing process seems to be OK. The recorder
is on its own IDE channel, the other channel is occupied by two
UDMA-100 disks, there are plenty of RAM and no processes eating CPU
that could break the writing process.

    Shouldn't the kernel report the writing errors? Should I contact
Joërg just in case cdrecord is behaving incorrectly?. Any hint?

    Thanks a lot in advance :)))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
