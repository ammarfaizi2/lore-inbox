Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWAJV2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWAJV2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWAJV2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:28:15 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54959 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932331AbWAJV2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:28:14 -0500
Date: Tue, 10 Jan 2006 22:28:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] kconfig: factor out ncurses check in a shell script
In-Reply-To: <20060110210115.GA16250@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0601102227210.15968@yvahk01.tjqt.qr>
References: <11368426843316@foobar.com> <Pine.LNX.4.61.0601102127230.16049@yvahk01.tjqt.qr>
 <20060110210115.GA16250@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I had ncursesw in my mind too when I did this.
>If you look at the test implemented to check for ncurses it
>should be simple to use same principle to check if one can use
>ncursesw. If gcc does not fail then ncursesw is present.
>
>Care to give it a spin?

Ah yes, keeping the gray cells in shape; let me give it a twist.


Jan Engelhardt
-- 
