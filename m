Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318844AbSHETJ3>; Mon, 5 Aug 2002 15:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318846AbSHETJ3>; Mon, 5 Aug 2002 15:09:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41455 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318844AbSHETJ2>; Mon, 5 Aug 2002 15:09:28 -0400
Subject: Re: Linux 2.4.19-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jt@hpl.hp.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020805174646.GH10011@bougret.hpl.hp.com>
References: <20020805174646.GH10011@bougret.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 21:31:41 +0100
Message-Id: <1028579501.18478.74.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 18:46, Jean Tourrilhes wrote:
> Alan Cox wrote :
> >
> > Linux 2.4.19-ac2
> > o	Fix __FUNCTION__ in rest of irda drivers	(me)
> > o	Fix __FUNCTION__ in some more net/irda bits	(me)
> 
> 	Would you mind sending those patches to me so that I can push
> them toward 2.5.X at my next update ? I would hate to do the same job
> twice. Thanks...
> 
> 	Also : I'm planning to dump some of my IrDA patch queue to
> Marcelo real soon. I would hate to see my bug fixes colliding with
> your cosmetic changes. Could you tell me the status of those fixes
> with respect to Marcelo ?

I can send them to Marcelo or I can send them to you. The stuff I sent
so far I cc'd to Dag Brattli since he's in maintainers. I've most but
not all of irda done. Just tell me which way around you want to do it


Alan

