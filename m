Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSHYMWr>; Sun, 25 Aug 2002 08:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSHYMWr>; Sun, 25 Aug 2002 08:22:47 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:39047 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317334AbSHYMWr>; Sun, 25 Aug 2002 08:22:47 -0400
Message-ID: <3D68CD62.C3E59923@wanadoo.fr>
Date: Sun, 25 Aug 2002 14:28:18 +0200
From: kris <C.Devalquenaire@wanadoo.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2.5 Problem ne.c driver
References: <3D68C32C.AD7D9414@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kris wrote:
> 
> I have 2 ne2000 isa cards (10Mbps for each) and with this versions of
> kernel the bandwith is divided by 2. So 2*5Mbps = 10Mbps instead of
> 2*10Mbps=20Mbps.
> I try to fix the pbm.

perhaps a bug exists on the dispatcher when 2 identical cards exist.
Anyone have 2 identical cards for test ?
