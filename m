Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271434AbTGQOWC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271459AbTGQOWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:22:02 -0400
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:6151 "EHLO
	sirius.nix.badanka.com") by vger.kernel.org with ESMTP
	id S271434AbTGQOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:22:00 -0400
Message-Id: <200307171436.h6HEasHt032576@sirius.nix.badanka.com>
Date: Thu, 17 Jul 2003 16:36:54 +0200
From: Henrik Persson <nix@syndicalist.net>
To: linux-kernel@vger.kernel.org
Subject: Re: VESA Framebuffer dead in 2.6.0-test1
In-Reply-To: <20030716172331.3bd3610e.ttimo@idsoftware.com>
References: <200307161406.h6GE6iHt002041@sirius.nix.badanka.com>
	<200307161608.34637.m.watts@eris.qinetiq.com>
	<20030716172331.3bd3610e.ttimo@idsoftware.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a heads-up for you that made the same mistake in the
menuconfig-jungle as I did:

If you want framebuffer console support, don't forget the
CONFIG_FRAMEBUFFER_CONSOLE ;o)

-- 
Henrik Persson  nix@syndicalist.net  http://nix.badanka.com
