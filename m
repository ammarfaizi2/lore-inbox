Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUAKXNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUAKXNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:13:21 -0500
Received: from bay7-dav33.bay7.hotmail.com ([64.4.10.90]:11524 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266022AbUAKXNF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:13:05 -0500
X-Originating-IP: [66.191.177.153]
X-Originating-Email: [ameer_armaly@hotmail.com]
From: "Ameer Armaly" <Ameer_Armaly@hotmail.com>
To: "linux kernel" <linux-kernel@vger.kernel.org>
Subject: patch: arch/i386/boot/install.sh
Date: Sun, 11 Jan 2004 18:13:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY7-DAV33eiTsSnJWI0002cadd@hotmail.com>
X-OriginalArrivalTime: 11 Jan 2004 23:13:04.0996 (UTC) FILETIME=[779DBA40:01C3D898]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to the i386 install script, which actually makes make
install work, at least on my system; let me know how it works on yours.  For
some reason, I had to pass the arguments to installkernel separately;  the
original "$@" wouldn't work.   the diff is at
ftp://ftp.linux-speakup.org/pub/incoming/install.sh.dif since hotmail won't
let me send via linux, and OE keeps wordwrapping the diff whenever I paste
it in; if anyone knows how to get linux working with hotmail, please send me
privately.
Thanks,



Ameer
