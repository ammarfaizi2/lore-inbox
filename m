Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280880AbRKBXfZ>; Fri, 2 Nov 2001 18:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280881AbRKBXfQ>; Fri, 2 Nov 2001 18:35:16 -0500
Received: from air-1.osdl.org ([65.201.151.5]:8209 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S280880AbRKBXfG>;
	Fri, 2 Nov 2001 18:35:06 -0500
Message-ID: <3BE32B9E.99F57470@osdl.org>
Date: Fri, 02 Nov 2001 15:26:22 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Lavoie <clavoie@bmed.mcgill.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disabling CPUs -- at runtime?
In-Reply-To: <20011102232536Z280877-17408+9634@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Lavoie wrote:
> 
> Is it possible to disable a CPU on a dual machine while the kernel is
> running? (Intel PIIIs, Asus motherboards -- VIA686B based)
> 
> Parsing of the relevant documentation didn't find an answer...

There's a patch [out of date :( ] at
sourceforge.net/projects/lhcs/ that does this (CPU online/offline).

~Randy
