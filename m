Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbTJUU6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTJUU6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:58:53 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:36357 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263386AbTJUU6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:58:09 -0400
Subject: Re: [test8] Oops after trying to access USB-device /dev/sda
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jens Kubieziel <linux-kernel@kubieziel.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20031021194143.GI1133@kubieziel.de>
References: <20031021194143.GI1133@kubieziel.de>
Content-Type: text/plain
Message-Id: <1066769879.866.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Tue, 21 Oct 2003 22:57:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 21:41, Jens Kubieziel wrote:
> I assume that this are the relevant lines from syslog (The whole usb-part
> is available at http://www.kubieziel.de/tmp/syslog-errors):

Please, use pass the oops through ksymoops. We need debuging information
and symbols instead of those raw addresses.
Thanks!

