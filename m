Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWBJRXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWBJRXW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWBJRXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:23:22 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36238 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751335AbWBJRXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:23:21 -0500
Subject: Re: disabling libata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Imre Gergely <imre.gergely@astral.ro>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43ECB91E.6060109@astral.ro>
References: <43EC97C6.10607@astral.ro>
	 <20060210141130.GE28676@harddisk-recovery.com> <43ECA035.5040302@astral.ro>
	 <20060210142224.GF28676@harddisk-recovery.com> <43ECB91E.6060109@astral.ro>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Feb 2006 17:25:47 +0000
Message-Id: <1139592347.12521.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-02-10 at 18:02 +0200, Imre Gergely wrote:
> maybe it's just me... but it looks like if as SCSI device the whole thing is
> slower than with IDE. i haven't tested it yet, but as sda the system load is
> very high, i did some tests with dd, and the CPU usage is always at 98-100%.


Not expected behaviour. Can you provide hardware info and boot up
messages please.

