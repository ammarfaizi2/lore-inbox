Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbTCCQjd>; Mon, 3 Mar 2003 11:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268445AbTCCQjd>; Mon, 3 Mar 2003 11:39:33 -0500
Received: from air-2.osdl.org ([65.172.181.6]:53189 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268432AbTCCQjc>;
	Mon, 3 Mar 2003 11:39:32 -0500
Date: Mon, 3 Mar 2003 08:44:52 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: chris Allen <cyo@mychristiannetwork.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet Pro 100
Message-Id: <20030303084452.67ae3bfa.rddunlap@osdl.org>
In-Reply-To: <5.2.0.9.0.20030303103737.00b28068@mychristiannetwork.com>
References: <5.2.0.9.0.20030303103737.00b28068@mychristiannetwork.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Mar 2003 10:38:19 -0600
chris Allen <cyo@mychristiannetwork.com> wrote:

| I am trying to compile Ethernet Pro 100 into the linux kernel and don't know
| what ethernet device i should use to make it compile

This driver is for an Intel (EtherExpress) PRO/100 ethernet adapter
which works at 10 Mbps or 100 Mbps.
However, you don't have to have an adapter to compile the driver into
the kernel.

--
~Randy
