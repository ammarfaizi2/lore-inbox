Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTLOSUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbTLOSUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:20:23 -0500
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:18952 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S263902AbTLOSTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:19:25 -0500
Date: Mon, 15 Dec 2003 20:19:58 +0100 (CET)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [2.6] Modular IDE - problem
In-Reply-To: <200312130057.45799.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.58L.0312152009450.16239@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0312121432190.11533@alpha.zarz.agh.edu.pl>
 <200312121431.56416.bzolnier@elka.pw.edu.pl> <200312130057.45799.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is broken :(

Sorry, Bart.
When I appaly this,compilation looks OK. but when I try tu run
kernel from initrd with ide_disk I'v got many errors:
ie. unknow ide_fops, ide_raw-taskfile, do_rw_taskfile, 
proc_ide_read_geometry ...
and many other ...

Can You look at this ?
				Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
