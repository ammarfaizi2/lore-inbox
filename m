Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbUL1O4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUL1O4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 09:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbUL1O4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 09:56:05 -0500
Received: from rekin10.go2.pl ([193.17.41.30]:24789 "EHLO r10.go2.pl")
	by vger.kernel.org with ESMTP id S261242AbUL1O4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 09:56:00 -0500
From: =?iso-8859-2?Q?Fryderyk_Mazurek?= <dedyk@go2.pl>
To: =?iso-8859-2?Q?Len_Brown?= <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: =?iso-8859-2?Q?Re:_Problems_with_2.6.10?=
Date: Tue, 28 Dec 2004 15:56:00 +0100
Content-Type: text/plain; charset="iso-8859-2";
Content-Transfer-Encoding: 8bit
X-Mailer: o2.pl WebMail v5.27
X-Originator: 83.31.161.254
In-Reply-To: <1104201851.18175.39.camel@d845pe>
References: <20041227171159.51454193BFA@r10.go2.pl> 
	<1104201851.18175.39.camel@d845pe>
Message-Id: <20041228145600.6A9FC193D36@r10.go2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

My kernel 2.6.10 I compiled two times. First with ACPI and second
fully without ACPI. And the same situation.
For me this situation is strange, because usually reset should help,
but not this time. I thought that maybe my BIOS is too old. But with
2.6.9 works. Therefore I don't know. Now I use 2.6.9.

Fryderyk.

---- Wiadomo¶æ Oryginalna ----
Od: Len Brown <len.brown@intel.com>
Do: Fryderyk Mazurek <dedyk@go2.pl>
Kopia do: linux-kernel@vger.kernel.org
Data: 27 Dec 2004 21:44:11 -0500
Temat: Re: Problems with 2.6.10

> On Mon, 2004-12-27 at 12:11, Fryderyk Mazurek wrote:
> 
> > problem starts when I do reboot. On boot screen my bios can't detect
> > my disk. Bios stops and nothing.
> 
> Does reboot work if the initial boot is with acpi=off?
> 
> 
> 
