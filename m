Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUBGGkh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 01:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUBGGkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 01:40:36 -0500
Received: from smtp-out6.xs4all.nl ([194.109.24.7]:48145 "EHLO
	smtp-out6.xs4all.nl") by vger.kernel.org with ESMTP id S266650AbUBGGkc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 01:40:32 -0500
Date: Sat, 7 Feb 2004 07:40:27 +0100
From: Jurriaan on adsl-gate <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: Keyboard on ... reports too many keys pressed
Message-ID: <20040207064027.GA20495@gates.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my laptop, I get a lot of

Keyboard on ... reports too many keys pressed.

That may well be the case, I use my normal hands on a small
laptop-keyboard.
Why is that message printed? There nothing I can do about pressing
multiple keys by accident, so I don't think it's useful.

It does, however, frequently mess up the commandline, which leads to big
frustration.

Couldn't this be wrapped in #ifdef ATKBD_DEBUG or something? Is it
really necessary to see this message?

Good luck,
Jurriaan
