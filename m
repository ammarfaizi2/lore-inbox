Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261634AbTCGQJ2>; Fri, 7 Mar 2003 11:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbTCGQJ2>; Fri, 7 Mar 2003 11:09:28 -0500
Received: from air-2.osdl.org ([65.172.181.6]:65410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261634AbTCGQJ1>;
	Fri, 7 Mar 2003 11:09:27 -0500
Date: Fri, 7 Mar 2003 08:18:16 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mzyngier@freesurf.fr
Cc: akpm@digeo.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix fs/binfmt_elf.c build
Message-Id: <20030307081816.40088fbc.rddunlap@osdl.org>
In-Reply-To: <wrpy93r61q1.fsf@hina.wild-wind.fr.eu.org>
References: <wrpy93r61q1.fsf@hina.wild-wind.fr.eu.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Mar 2003 09:05:26 +0100 Marc Zyngier <mzyngier@freesurf.fr> wrote:

| Andi,
| 
| The stack reducing patch that recently went in prevent alpha from
| building (missing some ELF_CORE_COPY_XFPREGS ifdefs). The excluded
| patch fixes it.
| 
| Thanks,

Ugh, sorry about that.

--
~Randy
