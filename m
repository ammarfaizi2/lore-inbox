Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTD2SMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 14:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTD2SMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 14:12:02 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:28138 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262118AbTD2SMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 14:12:02 -0400
Date: Tue, 29 Apr 2003 20:24:14 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [FLAME]: Log and console pollution: ip_tables: (C) 2000-2002
 Netfilter core team
In-Reply-To: <200304300136.30478.mflt1@micrologica.com.hk>
Message-ID: <Pine.LNX.4.51.0304292016140.28027@dns.toxicfilms.tv>
References: <200304300136.30478.mflt1@micrologica.com.hk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Gladly, most humble authors refrain from this bloat.
Strange, i though we are coding for fame and glory ? :)

But seriously...
You see these messages only when you load the module. On a
non-testbed-machine it is once a boot. I would not call that polluting
the logs.

On the other hand on a testbed-machine you see these messages when you
load and reload the modules. I treat these messages as debug messages.
When I develop a module i put versioning info there, and i know if I
loaded the correct module or some previous version.

Regards,
Maciej Soltysiak

-----BEGIN GEEK CODE BLOCK-----
VERSION: 3.1
GIT/MU d-- s:- a-- C++ UL++++$ P L++++ E- W- N- K- w--- O! M- V- PS+ PE++
Y+ PGP- t+ 5-- X+ R tv- b DI+ D---- G e++>+++ h! y?
-----END GEEK CODE BLOCK-----
