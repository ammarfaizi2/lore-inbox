Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbTIAQqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTIAQqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:46:07 -0400
Received: from TEST.13thfloor.at ([212.16.62.51]:26507 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263016AbTIAQqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:46:05 -0400
Date: Mon, 1 Sep 2003 18:46:04 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Bind Mount Extensions (RO --bind)
Message-ID: <20030901164604.GA20499@DUK2.13thfloor.at>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Marcelo says, if you give your okay to the Bind
Mount Extensions, they can go in 2.4.23 ...

I'm personally interested in your opinion to the
latest patches (bme0.03 for 2.4 and 2.6) so please
be so kind, have a look at them, and let me know if
they are okay and/or what is missing/wrong ...

please consider update_atime() isn't implemented 
yet, because I wanted to wait for your reply, and
intermezzo is missing, because I didn't want to
do the same 'probably faulty' stuff twice, both
will be added as soon as I have some response ...

TIA,
Herbert

PS: if you need anything regarding those patches, 
please let me know ...

