Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTE2K2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTE2K2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:28:14 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:32915 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262123AbTE2K2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:28:14 -0400
Date: Thu, 29 May 2003 12:37:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.70: random lockups on toshiba 4030cdt notebook
Message-ID: <20030529103751.GA1181@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I first thought that i2c-piix4 support was responsible, so I disabled
it, but hangs stayed. They are quite frequent (like "will not usually
finish fsck") and IIRC they were not there in 2.5.69...

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
