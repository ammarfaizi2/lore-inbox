Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTFTOTS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTFTOTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:19:18 -0400
Received: from thor.65535.net ([65.214.160.96]:54285 "EHLO thor.65535.net")
	by vger.kernel.org with ESMTP id S262299AbTFTOTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:19:14 -0400
Date: Fri, 20 Jun 2003 15:34:05 +0100 (BST)
From: Rus Foster <rghf@fsck.me.uk>
To: Thomas Frase <thomas.frase@ist-einmalig.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: root shell exploit still working in kernel 2.4.21
In-Reply-To: <004d01c33738$7031e440$0200a8c0@brainbug>
Message-ID: <20030620153321.V31879@thor.65535.net>
References: <004d01c33738$7031e440$0200a8c0@brainbug>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003, Thomas Frase wrote:

> hello!
>
> the problem:
> i tried an exploit (url given below) with debian woody kernel 2.4.18
> and self compiled kernel 2.4.21 resulting in a root shell.
>

Under 2.4.21 delete the binary, recompile it and see if it still happens.
The binary sets itself SUID IIRC

Rgds

Rus

--
www: http://www.65535.net       | Hosting - Shell Accounts
MSNM: support@65535.net		| Virtual Servers from just $15/mo
e: rghf@65535.net               | Community: http://www.65535.org
t: +44 (0) 7092016595           | 10% Donation on every FreeBSD product

