Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314282AbSEIUNB>; Thu, 9 May 2002 16:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314287AbSEIUNA>; Thu, 9 May 2002 16:13:00 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:14104 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S314282AbSEIUM7>; Thu, 9 May 2002 16:12:59 -0400
Date: Thu, 9 May 2002 21:20:11 +0100
From: Ian Molton <spyro@armlinux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@transmeta.com, dalecki@evision-ventures.com, andre@linux-ide.org,
        bjorn.wesen@axis.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE 58
Message-Id: <20020509212011.6a1d5afd.spyro@armlinux.org>
In-Reply-To: <20020508191054.6282@smtp.wanadoo.fr>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.7.5cvs1 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002 21:10:54 +0200
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> That would cleanly solve my problem of mixing MMIO and PIO
> controllers in the same machine, that would solve the crazy
> byteswapping needed by some controllers for PIO at least,
> etc...

Its good here on the old and slightly odd Acorn Podule bus interface...
