Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272573AbTG1AmI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272572AbTG1AEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:20 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272724AbTG0W6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:19 -0400
Subject: Re: 2.6.0-test2 OSS emu10k1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030727190257.GA2840@localhost.localdomain>
References: <20030727190257.GA2840@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059338379.13871.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 21:39:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-27 at 20:02, Balram Adlakha wrote:
> I cannot compile the emu10k1 module:
> 
> sound/oss/emu10k1/hwaccess.c:182: redefinition of `emu10k1_writefn0_2'
> sound/oss/emu10k1/hwaccess.c:164: `emu10k1_writefn0_2' previously defined here

Looks like bad patching 182 is unrelated in my tree

