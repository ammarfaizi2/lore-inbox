Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTDES3s (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 13:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTDES3r (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 13:29:47 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:37381 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262577AbTDES3r (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 13:29:47 -0500
Date: Sat, 5 Apr 2003 20:41:14 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Anant Aneja <anantaneja@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: poweroff problem
Message-ID: <20030405184114.GB554@alpha.home.local>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405060804.31946.qmail@webmail5.rediffmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 06:08:04AM -0000, Anant Aneja wrote:
 
> i know that the kernel is old but i dont want to update
> cos my modem has a low download speed

you may try to get small chunks of a new one each time you connect to the net
so that after several hours of nearly normal browsing, you'll get a new kernel
as a bonus.

> also i cant give u the complete listing of the cpu
> registers since it occurs at the last stage
> of shutdown and i cant copy it to a file
> and am too lazy to write it down
> 
> can anyone help me ?

at least, try to patch it with kmsgdump to retrieve the last kernel messages
on a floppy. You'll find it easily if you're not too lazy for that ;-)

Willy
