Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265076AbTGBP5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbTGBP5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:57:52 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:38869 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S265076AbTGBP5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:57:51 -0400
Message-Id: <5.1.0.14.2.20030702091043.05f61158@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 02 Jul 2003 09:12:02 -0700
To: Jan Dittmer <jan.dittmer@tu-harburg.de>, linux-kernel@vger.kernel.org
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Bluetooth rfcomm tty layer initialization
Cc: marcel@holtmann.org
In-Reply-To: <3F029CA1.3010001@tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:49 AM 7/2/2003, Jan Dittmer wrote:
>This was in 2.5 for a while. Happens when loading the rfcomm module.
>Anything more needed for this? All bluetooth stuff is modular, and I'm using devfs.
>I cannot capture the start of the rfcomm loading, the messages are scrolling far too 
>fast and I don't have a serial console handy right now, sorry.
Yep. I'm aware of that problem. It's on my TOFIX list :)

Max

