Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270843AbTGPNvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270845AbTGPNvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:51:54 -0400
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:53773 "EHLO
	sirius.nix.badanka.com") by vger.kernel.org with ESMTP
	id S270843AbTGPNvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:51:53 -0400
Message-Id: <200307161406.h6GE6iHt002041@sirius.nix.badanka.com>
Date: Wed, 16 Jul 2003 16:06:43 +0200
From: Henrik Persson <nix@syndicalist.net>
To: linux-kernel@vger.kernel.org
Subject: VESA Framebuffer dead in 2.6.0-test1
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

A number of people have experienced the same problem as I have; the VESA
framebuffer is just..black on boot. I haven't seen any reports on this,
though. dmesg says what it always have said before about the fb.

I boot with vga=791 (as specified in lilo.conf).. Have something changed
or is it just broken? :o)

Thanks.

-- 
Henrik Persson  nix@syndicalist.net  http://nix.badanka.com
