Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263646AbUFBFh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUFBFh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 01:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUFBFh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 01:37:26 -0400
Received: from outmx019.isp.belgacom.be ([195.238.2.200]:3504 "EHLO
	outmx019.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263646AbUFBFhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 01:37:25 -0400
Subject: Re: why swap at all?
From: FabF <fabian.frederick@skynet.be>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain
Message-Id: <1086154721.2275.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 02 Jun 2004 07:38:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 01:17, Bernd Eckenfels wrote:
> In article <200406012000.i51K0vor019011@turing-police.cc.vt.edu> you wrote:
> > out (unlike some, I don't mind if Mozilla or OpenOffice end up out on
> > disk after extended inactivity - but if my window manager gets swapped
> > out, I get peeved when focus-follows-mouse doesn't and my typing goes
> > into the wrong window or some such... ;)
> 
> Yes but: your wm is so  often used/activated it will not get swaped  out. 
> But if your mouse passes over mozilla and tries to focus it, then you will
> feel the pain of a swapped-out x program.
> 
Exactly !
Does autoregulated VM swap. patch could help here ?

FabF

> Greetings
> Bernd

