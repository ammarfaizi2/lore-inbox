Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTEZSBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTEZSBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:01:07 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62296 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262008AbTEZSBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:01:03 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200305261814.h4QIEAV28934@devserv.devel.redhat.com>
Subject: Re: [PATCH] IDE: fix "biostimings" and legacy chipsets' boot parameters interaction
To: B.Zolnierkiewicz@elka.pw.edu.pl (Bartlomiej Zolnierkiewicz)
Date: Mon, 26 May 2003 14:14:10 -0400 (EDT)
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <200305261635.05348.bzolnier@elka.pw.edu.pl> from "Bartlomiej Zolnierkiewicz" at Mai 26, 2003 04:35:05 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IDE: fix "biostimings" and legacy chipsets' boot parameters interaction.

I have to admit I don't care since biostimings is a stupid patch Linus
forced into the tree against my wishes. Its a great way to lose all your
data if you turn it on
