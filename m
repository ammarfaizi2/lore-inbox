Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319130AbSIJODo>; Tue, 10 Sep 2002 10:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319128AbSIJOCq>; Tue, 10 Sep 2002 10:02:46 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:50981 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S319123AbSIJOCi>; Tue, 10 Sep 2002 10:02:38 -0400
Date: Tue, 10 Sep 2002 16:09:30 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: which driver for a Dlink DFE 650TXD (PCMCIA) ?
Message-Id: <20020910160930.791c0b61.kristian.peters@korseby.net>
In-Reply-To: <20020910080403.GA958@debian>
References: <20020910080403.GA958@debian>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686-debian-linux-gnu 2.4.19
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Wirtel <stephane.wirtel@belgacom.net> schrieb:
> i haven't found the driver for my pcmcia card.
> 
> my kernel is the 2.4.20-pre5-ac4.

Have you tried pcmcia-cs ? Your card is at least supported there:
http://pcmcia-cs.sourceforge.net/ftp/SUPPORTED.CARDS

But afaik the config option "D-Link DE620 pocket adapter support" also supports your card.

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
