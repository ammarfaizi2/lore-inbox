Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVAOMf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVAOMf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 07:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVAOMf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 07:35:58 -0500
Received: from albireo.ucw.cz ([81.27.203.89]:51589 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S262268AbVAOMfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 07:35:55 -0500
Date: Sat, 15 Jan 2005 13:35:54 +0100
From: Martin Mares <mj@ucw.cz>
To: Enrico Bartky <DOSProfi@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lspci != scanpci !?
Message-ID: <20050115123554.GA2115@ucw.cz>
References: <003d01c4fa7b$983b21b0$0c00a8c0@amd64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003d01c4fa7b$983b21b0$0c00a8c0@amd64>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Now the scanpci command shows the M7101 BUT lspci and /proc/pci,
> /proc/bus/pci, /sys/bus/pci NOT. What can I do? Is there anything like a
> "update_pci" command?

What does `lspci -vv -M' and `lspci -vv -M -H1' print?

(Please Cc to me, I usually read LKML in large batches.)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Air conditioned environment -- Do not open Windows.
