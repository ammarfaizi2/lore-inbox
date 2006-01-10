Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWAJU1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWAJU1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWAJU1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:27:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34492 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932355AbWAJU1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:27:44 -0500
Date: Tue, 10 Jan 2006 21:27:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] kconfig: factor out ncurses check in a shell script
In-Reply-To: <11368426843316@foobar.com>
Message-ID: <Pine.LNX.4.61.0601102127230.16049@yvahk01.tjqt.qr>
References: <11368426843316@foobar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Cleaning up the lxdialog Makefile by factoring out the
>ncurses compatibility checks.
>This made the checks much more obvious and easier to extend.

BTW, do you know a nice way to detect ncursesw?




Jan Engelhardt
-- 
