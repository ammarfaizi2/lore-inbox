Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261695AbTCaQAZ>; Mon, 31 Mar 2003 11:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbTCaQAZ>; Mon, 31 Mar 2003 11:00:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261695AbTCaQAY>;
	Mon, 31 Mar 2003 11:00:24 -0500
Date: Mon, 31 Mar 2003 08:07:19 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "S.Gopi" <sekargopi@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Issues in 2.5.65-ac4
Message-Id: <20030331080719.3aa1f151.rddunlap@osdl.org>
In-Reply-To: <1048920381.2383.22.camel@Agni>
References: <1048920381.2383.22.camel@Agni>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Mar 2003 12:16:21 +0530 "S.Gopi" <sekargopi@yahoo.com> wrote:

| Hai,
|  
| Second question: where is /proc/pci gone?

It's now a config option:
CONFIG_PCI_LEGACY_PROC=y


--
~Randy
