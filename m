Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266007AbSKBSd1>; Sat, 2 Nov 2002 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266004AbSKBSd0>; Sat, 2 Nov 2002 13:33:26 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3969 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S266007AbSKBSd0>;
	Sat, 2 Nov 2002 13:33:26 -0500
Date: Sat, 2 Nov 2002 12:39:53 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd still borken for me in 2.5.45
In-Reply-To: <20021102154323.GB2177@suse.de>
Message-ID: <Pine.LNX.4.44.0211021232190.1334-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Jens Axboe wrote:

> There's at least one report of that patch fixing the issue. Thomas, I'd
> like you to try it too.

It worked for me :)  I also replaced the redhat-standard versions of the 
cdrecord tools with the rpms you have on ftp.kernel.org.  I was able to do 
all my cd/cd-rw tasks and specify /dev/hdd and /dev/hdc for cdrecord with 
no trouble.

