Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbUAETJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbUAETJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:09:15 -0500
Received: from mx.laposte.net ([81.255.54.11]:26042 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S265321AbUAETIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:08:34 -0500
Subject: Re: Possibly wrong BIO usage in ide_multwrite
From: Frederik Deweerdt <frederik.deweerdt@laposte.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200401051712.41695.bzolnier@elka.pw.edu.pl>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net>
	 <200401032302.32914.bzolnier@elka.pw.edu.pl>
	 <1073237458.6069.31.camel@leto.cs.pocnet.net>
	 <200401051712.41695.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1073331448.3761.12.camel@silenus.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 20:37:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 17:12, Bartlomiej Zolnierkiewicz wrote:
> - hangs during reading /proc/ide/<cdrom>/identify on some drives
>   (workaround is now known thanks to debugging done by Andi+BenH+Andre)
could you explain about this workaround? i've searched the archives
without finding anything.
--
fred

