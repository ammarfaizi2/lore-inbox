Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbTDFG2W (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 01:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbTDFG2V (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 01:28:21 -0500
Received: from 078-037.onebb.com ([202.69.78.37]:23710 "EHLO
	nicksbox.tyict.vtc.edu.hk") by vger.kernel.org with ESMTP
	id S262835AbTDFG2V (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 01:28:21 -0500
Message-ID: <3E8FCBB8.199E8AE4@vtc.edu.hk>
Date: Sun, 06 Apr 2003 14:39:52 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-8custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Debugging hard lockups (hardware?)
References: <3E8FC9FB.A030ACFB@vtc.edu.hk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Urbanik wrote:

> Dear team,
>
> This machine locks up solid every few days.  Caps Lock, Num Lock, Scroll Lock do
> not respond.  The NMI watchdog does not kick in.  Alt-SysRq-keys do not
> respond.  Logs show no hint of any problem (that I recognise) before lockup.
> Occurs often during scrolling e.g., Mozilla.

I omitted one critical fact: it is only while I am using the machine sitting at the
console; it has never happened while connecting via ssh, even when doing plenty of
I/O.

--
Nick Urbanik   RHCE                                  nicku@vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



