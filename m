Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271264AbTHHHYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 03:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271272AbTHHHYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 03:24:50 -0400
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:32523 "EHLO
	sirius.nix.badanka.com") by vger.kernel.org with ESMTP
	id S271264AbTHHHYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 03:24:50 -0400
Message-Id: <200308080724.h787OHHt034890@sirius.nix.badanka.com>
Date: Fri, 8 Aug 2003 09:24:15 +0200
From: Henrik Persson <nix@syndicalist.net>
To: "Nicolas P." <linux@1g6.biz>
Cc: wenck@wapu.org, linux-kernel@vger.kernel.org, hermes@gibson.dropbear.id.au
Subject: Re: orinoco_cs: RequestIRQ: Unsupported mode
In-Reply-To: <200308080831.22218.linux@1g6.biz>
References: <20030808031706.GB20401@chaos.byteworld.com>
	<200308080831.22218.linux@1g6.biz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003 08:31:22 +0200
"Nicolas P." <linux@1g6.biz> wrote:

> Forgot my last mail, I checked
> 
> it was : orinoco_cs: RequestIRQ: Resource in use

Do you have CONFIG_ISA in your kernel?

-- 
Henrik Persson  nix@syndicalist.net  http://nix.badanka.com
