Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261635AbSJUUe7>; Mon, 21 Oct 2002 16:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbSJUUe7>; Mon, 21 Oct 2002 16:34:59 -0400
Received: from smtp1.home.se ([195.66.35.200]:41911 "EHLO smtp1.home.se")
	by vger.kernel.org with ESMTP id <S261635AbSJUUe5>;
	Mon, 21 Oct 2002 16:34:57 -0400
Message-ID: <001701c27942$278fc090$0219450a@sandos>
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Problem with thinkpad 760xl, (Trident FB) TGUI 96xx
Date: Mon, 21 Oct 2002 22:40:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The tridentfb driver isnt working very good

I did not get this to work, but I atleast managed to
get vesa-fb running. Vesa did not work on this machine
without UNIVBE, so I now use loadlin from a floppy to
load the kernel after Ive loaded UNIVBE, and then I use
vesafb, which seems to be working nicely, X using it
also. This should be pretty slow though. UNIVBE said
the chip had support for nearly nothing, and only
banked modes. Thats probably why the vesa-fb driver
didint work.

---
John Bäckstrand


