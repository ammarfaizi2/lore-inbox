Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbUALBlj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 20:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUALBlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 20:41:39 -0500
Received: from adsl-66-124-8-173.dsl.lsan03.pacbell.net ([66.124.8.173]:28852
	"EHLO cocoabitch") by vger.kernel.org with ESMTP id S265151AbUALBli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 20:41:38 -0500
Cc: linux-kernel@vger.kernel.org
To: Ameer_Armaly@hotmail.com
Subject: Re: patch: arch/i386/boot/install.sh
From: James Lamanna <jlamanna@ugcs.caltech.edu>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Sun, 11 Jan 2004 17:44:10 -0800
Message-ID: <opr1m23wnaz4tciz@192.168.1.1>
User-Agent: Opera7.22/Win32 M2 build 3221
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> me know how it works on yours. For some reason, I had to pass the 
> arguments to installkernel separately; the > original "$@" wouldn't 
> work. the diff is at 
> ftp://ftp.linux-speakup.org/pub/incoming/install.sh.dif since

What shell are you using on your system? (in other words, what is /bin/sh 
symlinked to..)
I wonder if *csh doesn't support $@ ... bash definitely does.
