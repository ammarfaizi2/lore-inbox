Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTI3Amv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 20:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbTI3Amv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 20:42:51 -0400
Received: from quechua.inka.de ([193.197.184.2]:9415 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263060AbTI3Amu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 20:42:50 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: pm: Revert swsusp to 2.6.0-test3
Date: Tue, 30 Sep 2003 02:43:13 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.09.30.00.43.13.7088@dungeon.inka.de>
References: <20030928100620.5FAA63450F@smtp-out2.iol.cz> <Pine.LNX.4.44.0309281038270.6307-100000@home.osdl.org> <20030928175853.GF359@elf.ucw.cz> <20030929204634.GA2425@elf.ucw.cz>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are both versions compatible? How to resume the right version?
Or simply resume=/dev/hda3 and the kernel will pick the right
mechanism to resume? 

Andreas

