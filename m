Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTHQKev (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 06:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTHQKev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 06:34:51 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:46216 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S263990AbTHQKeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 06:34:50 -0400
Message-ID: <138e01c364ab$15b6c2b0$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       "Andries Brouwer" <aebr@win.tue.nl>, "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Trying to run 2.6.0-test3
Date: Sun, 17 Aug 2003 18:57:44 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I knew it.  I knew it.

With a PS/2 keyboard, on a text console, only the yen and pipe key is
broken.  But with a USB keyboard, on a text console, the backslash and
underbar key is broken right along with the yen and pipe key.  These famous
two keys produce no input.

A few years ago I tried to persuade Andries Brouwer or Vojtech Pavlik to
accept a USB keyboard but they refused.  The patch which I sent to Vojtech
Pavlik was ignored and these two keys continued not to work (except on my
machine).  Finally Mike Fabian accepted a gift of a USB keyboard and this
defect in Linux got fixed.  But only for somewhere around the last half of
the 2.4 releases, not for 2.6.

What will it take this time?

