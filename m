Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVLIWns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVLIWns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVLIWns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:43:48 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:39698 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932486AbVLIWnr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:43:47 -0500
X-ME-UUID: 20051209224346721.B01161C0044A@mwinf0201.wanadoo.fr
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1134154208.14363.8.camel@mindpipe>
References: <1134154208.14363.8.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 09 Dec 2005 23:43:42 +0100
Message-Id: <1134168222.5270.1.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 09 décembre 2005 à 13:50 -0500, Lee Revell a écrit :
> I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
> I added -m64 to the CFLAGS as per the gcc docs. 

Under debian 32bits with 64bits kernel, I just add -m64 somewhere in the
main Makefile to rebuild my modules. Didn't try with a whole kernel
though.

	Xav


