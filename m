Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSHYNQX>; Sun, 25 Aug 2002 09:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSHYNQW>; Sun, 25 Aug 2002 09:16:22 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:9901 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317351AbSHYNQW>; Sun, 25 Aug 2002 09:16:22 -0400
Message-ID: <3D68D9F1.17A9A1B0@wanadoo.fr>
Date: Sun, 25 Aug 2002 15:21:53 +0200
From: Christophe Devalquenaire <C.Devalquenaire@wanadoo.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, becker@scyld.com
Subject: Re: 2.4 and 2.5 Problem ne.c driver
References: <3D68C32C.AD7D9414@wanadoo.fr> <3D68CD62.C3E59923@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kris wrote:
> 
> kris wrote:
> >
> > I have 2 ne2000 isa cards (10Mbps for each) and with this versions of
> > kernel the bandwith is divided by 2. So 2*5Mbps = 10Mbps instead of
> > 2*10Mbps=20Mbps.
> > I try to fix the pbm.
> 
> perhaps a bug exists on the dispatcher when 2 identical cards exist.
> Anyone have 2 identical cards for test ?

After other tries, the ne.c file is buggy. Confirmation.
I investigate. Anyone helps me ?

regards
Christophe
