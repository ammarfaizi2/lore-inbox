Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291316AbSBQX3Z>; Sun, 17 Feb 2002 18:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291317AbSBQX3P>; Sun, 17 Feb 2002 18:29:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17671 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291316AbSBQX27>;
	Sun, 17 Feb 2002 18:28:59 -0500
Message-ID: <3C703CB4.B3D7134E@mandrakesoft.com>
Date: Sun, 17 Feb 2002 18:28:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: linux-kernel@vger.kernel.org, khc@pm.waw.pl, davem@redhat.com,
        torvalds@transmeta.com
Subject: Re: [PATCH] HDLC patch for 2.5.5 (3/3)
In-Reply-To: <20020217193131.E14629@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> 
> [3/3]:
> - some devices are converted (c101.c/dscc4.c/farsync.c/n2.c).

looks ok to me, same comment as last e-mail (API changes cause the
driver code to look better, so it looks like the right direction)

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
