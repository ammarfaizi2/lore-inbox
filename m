Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbUAERLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUAERLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:11:39 -0500
Received: from smtp.terra.es ([213.4.129.129]:17738 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id S265198AbUAERKy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:10:54 -0500
Date: Mon, 5 Jan 2004 18:10:53 +0100
From: Diego Calleja <grundig@teleline.es>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Robert.L.Harris@rdlg.net, linux-kernel@vger.kernel.org
Subject: Re: mremap bug and 2.4?
Message-Id: <20040105181053.6560e1e3.grundig@teleline.es>
In-Reply-To: <Pine.LNX.4.58L.0401051323520.1188@logos.cnet>
References: <20040105145421.GC2247@rdlg.net>
	<Pine.LNX.4.58L.0401051323520.1188@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 5 Jan 2004 13:26:23 -0200 (BRST) Marcelo Tosatti <marcelo.tosatti@cyclades.com> escribió:

> On Mon, 5 Jan 2004, Robert L. Harris wrote:
> > Just read this on full disclosure:
> >
> > http://isec.pl/vulnerabilities/isec-0013-mremap.txt
[...]
> It is possible that the problem is exploitable. There is no known public
> exploit yet, however.
> 
> 2.4.24 includes a fix for this (mm/mremap.c diff)

It names 2.2 too. Is there a fix for 2.2?
