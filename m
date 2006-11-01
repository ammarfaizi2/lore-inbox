Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946808AbWKAMDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946808AbWKAMDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423975AbWKAMDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:03:37 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32461 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423960AbWKAMDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:03:37 -0500
Subject: Re: preferred way of fw loading
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       R.E.Wolff@BitWizard.nl
In-Reply-To: <4547E720.4080505@gmail.com>
References: <4547E720.4080505@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Nov 2006 12:07:32 +0000
Message-Id: <1162382853.11965.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-01 am 01:15 +0100, ysgrifennodd Jiri Slaby:
> Hello,
> 
> is preferred to have firmware in kernel binary (and go through array of chars)
> or userspace (and load it through standard kernel api)?

User space.

Alan

