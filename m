Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVBIVRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVBIVRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVBIVRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:17:09 -0500
Received: from isilmar.linta.de ([213.239.214.66]:65189 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261926AbVBIVRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:17:06 -0500
Date: Wed, 9 Feb 2005 22:17:05 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Michaela Merz <misch@steyla.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB / PCMCIA not working/panic on AVERATEC 3500
Message-ID: <20050209211705.GA27735@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Michaela Merz <misch@steyla.com>, linux-kernel@vger.kernel.org
References: <32801.216.79.129.219.1107144596.squirrel@www.steyla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32801.216.79.129.219.1107144596.squirrel@www.steyla.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Socket status: 00000720

This looks strange. Socket status 00000720 can't really be true -- I assume
there is a problem with the resource allocation. Can you send me
/proc/iomem
/proc/ioport

please?

Thanks,
	Dominik
