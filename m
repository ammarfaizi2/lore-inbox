Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVBUTn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVBUTn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 14:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVBUTmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 14:42:43 -0500
Received: from levante.wiggy.net ([195.85.225.139]:58060 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262085AbVBUTmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 14:42:32 -0500
Date: Mon, 21 Feb 2005 20:42:27 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: 2.6.11rc4: irq 5, nobody cared
Message-ID: <20050221194227.GH6722@wiggy.net>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
	Matthias-Christian Ott <matthias.christian@tiscali.de>,
	=?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20050220155600.GD5049@vanheusden.com> <4218C692.9040106@tiscali.de> <20050220180550.GA18606@ime.usp.br> <200502211943.59887.bzolnier@elka.pw.edu.pl> <421A2D8F.3050704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421A2D8F.3050704@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Jeff Garzik wrote:
> You should add this to your procmailrc :)
> 
> # Nuke duplicate messages
> :0 Wh: msgid.lock
> | $FORMAIL -D 32768 msgid.cache

That has the nasty side-effect of spreading messages for a single
discussion amongst many different mailboxes depending on which path
happens to be the first to deliver an email to you.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
