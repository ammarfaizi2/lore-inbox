Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263403AbUJ2PDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263403AbUJ2PDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbUJ2O7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:59:43 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:10965 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263386AbUJ2Ox5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:53:57 -0400
Date: Fri, 29 Oct 2004 16:53:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jan Kara <jack@suse.cz>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Configurable Magic Sysrq
In-Reply-To: <20041029145022.GA31945@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.53.0410291651530.18142@yvahk01.tjqt.qr>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz>
 <20041029024651.1ebadf82.akpm@osdl.org> <yw1xu0sdiwr2.fsf@inprovide.com>
 <20041029133527.GA25172@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.53.0410291632310.16820@yvahk01.tjqt.qr>
 <20041029145022.GA31945@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  It's not about the kernel size but about allowing user to invoke just
>some functions and not the other (see my other mail).

That's like giving a user m$ windows without the ctrl+alt+del functionality,
if you omit considering that either os has a different level of stability.

But I like the idea. Maybe a bitmask which can be set via /proc/sys/.../xxx?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
