Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbSJDPUR>; Fri, 4 Oct 2002 11:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262032AbSJDPTI>; Fri, 4 Oct 2002 11:19:08 -0400
Received: from [213.228.128.56] ([213.228.128.56]:28893 "HELO
	front1.netvisao.pt") by vger.kernel.org with SMTP
	id <S262023AbSJDPSk>; Fri, 4 Oct 2002 11:18:40 -0400
Date: Fri, 4 Oct 2002 16:30:50 +0100
From: "Paulo Andre'" <fscked@netvisao.pt>
To: Dexter Filmore <Dexter.Filmore@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: apply *both* patches? (newbie question)
Message-Id: <20021004163050.3ca7e869.fscked@netvisao.pt>
In-Reply-To: <20021004144915.4e381f98.Dexter.Filmore@gmx.de>
References: <20021004144915.4e381f98.Dexter.Filmore@gmx.de>
Organization: Tool Enterprises
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002 14:49:15 +0200
Dexter Filmore <Dexter.Filmore@gmx.de> wrote:

> Let's say I wanna try 2.4.20pre8aa2 - do I only have to apply the -aa
> patch or the pre8-patch *first* and *then* the -aa?

You have to apply 2.4.20pre8 on top of stock 2.4.19 first and only then
apply the aa2 patch.

	-- Paulo
