Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310212AbSCGUqC>; Thu, 7 Mar 2002 15:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310519AbSCGUpv>; Thu, 7 Mar 2002 15:45:51 -0500
Received: from stingr.net ([212.193.33.37]:13193 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S310212AbSCGUpj>;
	Thu, 7 Mar 2002 15:45:39 -0500
Date: Thu, 7 Mar 2002 23:45:26 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19pre2-ac3
Message-ID: <20020307204526.GG28744@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E16iyh2-0002OY-00@the-village.bc.nu> <20020307172806.GA28141@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020307172806.GA28141@matchmail.com>
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Mike Fedyk:
> > o	Fix quota deadlock and extreme load corruption	(Jan Kara, Chris Mason)
> 
> Corruption of what?  Quota meta-data?

Maybe - I've got  weird quota entries about same uid on same filesystem with
-pre2-ac2. But this was patched by me to add reiserfs quota so I thought
that was my fault :)

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
