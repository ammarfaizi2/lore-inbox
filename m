Return-Path: <linux-kernel-owner+willy=40w.ods.org-S290453AbUKAXpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S290453AbUKAXpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S290221AbUKAXmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:42:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16854 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S381641AbUKAXdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 18:33:41 -0500
Date: Mon, 1 Nov 2004 15:33:12 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
Cc: zaitcev@redhat.com, Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 USB storage problems
Message-ID: <20041101153312.6616cd41@lembas.zaitcev.lan>
References: <200410121424.59584.worf@sbox.tu-graz.ac.at>
	<200411012040.33285.worf@sbox.tu-graz.ac.at>
	<20041101213501.GD18227@one-eyed-alien.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004 23:19:13 +0100, Wolfgang Scheicher <worf@sbox.tu-graz.ac.at> wrote:

> Looks like the driver is very new and a lot has yet to be done.

This is why it defaults to N in defconfig, and this is why the help for
CONFIG_BLK_DEV_UB says "If unsure, say N."

-- Pete
