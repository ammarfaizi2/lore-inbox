Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWBKPm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWBKPm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWBKPm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:42:28 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:59291 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932149AbWBKPm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:42:27 -0500
Date: Sat, 11 Feb 2006 16:42:06 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: [QUESTION] Your way doing kernel/module development
Message-ID: <20060211154206.GD5721@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g25bf368b-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to get some short but, however, fully descriptive statements about how
you do your module development. I mean, what your way of doing coding,
insmod-ing, rmmod-ing, ... And what about code, that cannot be <M>, just [*] or
must-be-built-in.

Hm, actually there's nothing more to say. Except that I'm tired of rebooting. ;)
I tried kexec() but somehow I dont have all IDE devices sometimes on 'kexec -e'.
So this just not a solution for me... :)

Marc
