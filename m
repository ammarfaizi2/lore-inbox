Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWIYGYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWIYGYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWIYGYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:24:53 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:62436 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751298AbWIYGYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:24:52 -0400
Date: Mon, 25 Sep 2006 08:24:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@mars.ravnborg.org>
Subject: Re: [PATCH 13/28] kbuild: make -rR is now default
In-Reply-To: <11591327051652-git-send-email-sam@ravnborg.org>
Message-ID: <Pine.LNX.4.61.0609250824020.18552@yvahk01.tjqt.qr>
References: 20060924210827.GA26969@uranus.ravnborg.org
 <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org>
 <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org>
 <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org>
 <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org>
 <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org>
 <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org>
 <11591327051652-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: [PATCH 13/28] kbuild: make -rR is now default
>
>Do not specify -rR anymore - it is default.

What do you mean, it is default? Did upstream (GNU make) enable it by 
default?


Jan Engelhardt
-- 
