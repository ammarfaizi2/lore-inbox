Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVBUVsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVBUVsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 16:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVBUVse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 16:48:34 -0500
Received: from levante.wiggy.net ([195.85.225.139]:34770 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262136AbVBUVsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 16:48:31 -0500
Date: Mon, 21 Feb 2005 22:48:29 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: 2.6.11rc4: irq 5, nobody cared
Message-ID: <20050221214829.GI6722@wiggy.net>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
	Matthias-Christian Ott <matthias.christian@tiscali.de>,
	=?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20050220155600.GD5049@vanheusden.com> <4218C692.9040106@tiscali.de> <20050220180550.GA18606@ime.usp.br> <200502211943.59887.bzolnier@elka.pw.edu.pl> <421A2D8F.3050704@pobox.com> <20050221194227.GH6722@wiggy.net> <421A4574.1000604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421A4574.1000604@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Jeff Garzik wrote:
> These are _duplicate_ messages.  The To/CC doesn't vary in my 
> experience.  Therefore, sorting on To/CC always guarantees my messages 
> go into the correct folder.

It depends highly on how you filter. It do not use To/Cc headers
to choose the mailbox to deliver a message in since that will not work
with things like bounces and aliases. Using headers like List-Id or
X-Mailing-List is reliable, but does not work with the duplicate
filtering you suggested.

It is a matter of choosing your own preference. And ours seem to differ.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
