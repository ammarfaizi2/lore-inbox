Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWEDUaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWEDUaw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 16:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWEDUaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 16:30:52 -0400
Received: from main.gmane.org ([80.91.229.2]:701 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030318AbWEDUaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 16:30:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: framebuffer broken in 2.6.16.x and 2.6.17-rc3 ?
Date: Thu, 4 May 2006 22:29:20 +0200
Message-ID: <gs7iuaocrzmp.s33e3qhm21bl.dlg@40tude.net>
References: <60f2b0dc0605021251i1c883617vf132e8bdeffd6c7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-17-56.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006 21:51:13 +0200, Olivier Fourdan wrote:

> I'm surprised noone has raised that issue yet, so I'm wondering if I'm
> missing something obvious :) When using the fb in 2.6.16.x and
> 2.6.17-rc3, the screen stays just black, nothing is displayed... I'm
> using the regular unaccelerated vesa framebuffer.

It may sound silly and it's probably not relevant to your case, but I
had this kind of result during a kernel upgrade some versions ago when
I forgot the fbcon module.

-- 
Giuseppe "Oblomov" Bilotta

"Da grande lotterò per la pace"
"A me me la compra il mio babbo"
(Altan)
("When I grow up, I will fight for peace"
 "I'll have my daddy buy it for me")

