Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269621AbRHCVaJ>; Fri, 3 Aug 2001 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269635AbRHCV37>; Fri, 3 Aug 2001 17:29:59 -0400
Received: from ip240.cvd2.rb1.bel.nwlink.com ([207.202.151.240]:31013 "EHLO
	zot.localdomain") by vger.kernel.org with ESMTP id <S269633AbRHCV3v>;
	Fri, 3 Aug 2001 17:29:51 -0400
To: linux-kernel@vger.kernel.org
Subject: How does "alias ethX drivername" in modules.conf work?
From: Mark Atwood <mra@pobox.com>
Date: 03 Aug 2001 14:29:58 -0700
Message-ID: <m33d78de7d.fsf@flash.localdomain>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to figure out how "alias ethX" works in /etc/modules.conf

Is it some "magic" in depmod / modprobe? And how is the network
interface identifier then passed into the module when it loads?

A nice whitepaper or doc or a few pointers or handholding would be
apprecated.

-- 
Mark Atwood   | I'm wearing black only until I find something darker.
mra@pobox.com | http://www.pobox.com/~mra
