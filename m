Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272507AbTHEPSy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272819AbTHEPSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:18:54 -0400
Received: from law11-oe35.law11.hotmail.com ([64.4.16.92]:44815 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S272507AbTHEPSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:18:41 -0400
X-Originating-IP: [165.98.111.210]
X-Originating-Email: [bmeneses_beltran@hotmail.com]
From: "Viaris" <bmeneses_beltran@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.6.0-test2 hang in Starting RedHat Network Daemon
Date: Tue, 5 Aug 2003 09:18:38 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <Law11-OE35phwFutJLt00010b17@hotmail.com>
X-OriginalArrivalTime: 05 Aug 2003 15:18:40.0341 (UTC) FILETIME=[D9ADD050:01C35B64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I have problems with this new kernel, I compiled the 2.6.0-test2 but when
start the services this kernel hang in the service starting RedHat Network,
the message are:

INIT:Id"1" respawning too fast: disabled for 5 minutes
INIT:Id"2" respawning too fast: disabled for 5 minutes
INIT:Id"3" respawning too fast: disabled for 5 minutes
INIT:Id"4" respawning too fast: disabled for 5 minutes
INIT:Id"5" respawning too fast: disabled for 5 minutes
INIT:Id"6" respawning too fast: disabled for 5 minutes
INIT:Id"4" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel.

I have in my grub.conf the oher kernel version 2.4.20, If I start with this
kernel, all work fine.

How can I to resolv this problem with new kernel?

Thanks in Advanced,

Regards

