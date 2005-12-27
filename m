Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVL0Loy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVL0Loy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 06:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVL0Loy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 06:44:54 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:18530 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751101AbVL0Lox convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 06:44:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H/rK7c3amQcRHW6Off7duyME/iwiBUkiTzb4tUO6g3/PhwIHQuratDHvATsEEDhTPkhDjZ6Ec2OiiXLnQQCikiE6g7hNefJQY7fzqTiOO/+/dM0J059vpUE0O+EVaHCYDgv2YULCRS6YGRDLyfu7fHGEpqgyCqR1XLqKcmKiMNo=
Message-ID: <28cc27130512270344o4670b4a6m@mail.gmail.com>
Date: Tue, 27 Dec 2005 12:44:52 +0100
From: Luuk van der Duim <luukvanderduim@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too have been bored during Christmas and ran 2.6.15-rc7 as Linus asked.

Furthermore I patched it with 'adaptive read-ahead', Ingo's mutex,
Balbirs/Stevens 'slab-cache estimate optimization' and Cons 'swap
prefetch'.
I've enable 4k stacks and kernel preemption and up till now I've yet
to see one glitch.

Usage: Watching movies, using git, compiling kernel, ftp, bittorrent..
Nothing special...

Machine is a Athlon 1.3 GHz, 512 MB Ram, 46xx sound ALSA ..

    Luuk van der Duim
