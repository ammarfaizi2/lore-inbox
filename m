Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268615AbTCCVrJ>; Mon, 3 Mar 2003 16:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268613AbTCCVrJ>; Mon, 3 Mar 2003 16:47:09 -0500
Received: from air-2.osdl.org ([65.172.181.6]:29831 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268615AbTCCVrI>;
	Mon, 3 Mar 2003 16:47:08 -0500
Date: Mon, 3 Mar 2003 13:52:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Smart notation for non-verbose output
Message-Id: <20030303135208.45e9e0b3.rddunlap@osdl.org>
In-Reply-To: <20030303215112.GA19798@mars.ravnborg.org>
References: <20030303215112.GA19798@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003 22:51:12 +0100
Sam Ravnborg <sam@ravnborg.org> wrote:

| Hi Kai.
| 
| Create a nice shorthand to enable the non-verbose output mode.
| make V=1	=> Gives verbose output (default)
| make V=0	=> Gives non-verbose output
| 
| One of the reasons why people does not use KBUILD_VERBOSE=0 that
| much is simply the typing needed.
| This notation should make it acceptable to type it.
| The usage of "make V=0" is restricted to the command line.
| Anyone that wants to enable the non-verbose mode pr. default shall
| set KBUILD_VERBOSE in the shell.

Nice.  Thank you.

--
~Randy
