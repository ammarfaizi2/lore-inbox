Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTDNT1Y (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbTDNT1Y (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:27:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3201 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263668AbTDNT1V convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:27:21 -0400
Date: Mon, 14 Apr 2003 12:38:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: top stack (l)users for 2.5.67
Message-Id: <20030414123810.7d61ece6.rddunlap@osdl.org>
In-Reply-To: <20030414173047.GJ10347@wohnheim.fh-wedel.de>
References: <20030414173047.GJ10347@wohnheim.fh-wedel.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003 19:30:47 +0200 Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:


| 0xc05e2733 ida_ioctl:                                    sub    $0x54c,%esp

patch posted 2003.APR.03 (on lkml); Steve Cameron saw it...

| 0xc0fb00e3 device_new_if:                                sub    $0x520,%esp

patch posted 2003.APR.03 (on linux-net);
no reply from Nenad Corbic (ncorbic@sangoma.com)


--
~Randy
