Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTIPMKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTIPMKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:10:32 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:64267 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261875AbTIPMKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:10:30 -0400
Subject: Re: Nearly succes with suspend to disk in -test5-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Mathieu LESNIAK <maverick@eskuel.net>, LKML <linux-kernel@vger.kernel.org>,
       mochel@osdl.org
In-Reply-To: <20030916114822.GB602@elf.ucw.cz>
References: <3F660BF7.6060106@eskuel.net>  <20030916114822.GB602@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1063714222.1302.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 16 Sep 2003 14:10:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-16 at 13:48, Pavel Machek wrote:

> cat you try with echo 4 > /proc/acpi/sleep?

It does nothing for me... No messages in the kernel ring, no intention
to perform a swsusp.

