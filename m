Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTJKJjR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 05:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTJKJjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 05:39:17 -0400
Received: from quechua.inka.de ([193.197.184.2]:19161 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263270AbTJKJjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 05:39:01 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Date: Sat, 11 Oct 2003 11:39:55 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.10.11.09.39.54.505616@dungeon.inka.de>
References: <227d01c38fd6$2e4764f0$5cee4ca5@DIAMONDLX60>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try the smartmontools package, it has "smartctl" that will
show you the discs S.M.A.R.T. details (i.e. how many bad
blocks the firmware knows, the errors the firmware knows
about, etc.). It can also run a self test etc.

doing a backup couldn't hurt.
btw: are you sure cables are ok?

Good Luck!

Andreas

