Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTFKABH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTFKABG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:01:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19141 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262323AbTFJX6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:58:49 -0400
Date: Tue, 10 Jun 2003 21:10:08 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Frank Cusack <fcusack@fcusack.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc8
In-Reply-To: <20030610165622.A17342@google.com>
Message-ID: <Pine.LNX.4.55L.0306102109340.30401@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0306101845460.30401@freak.distro.conectiva>
 <20030610165622.A17342@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Jun 2003, Frank Cusack wrote:

> On Tue, Jun 10, 2003 at 07:06:15PM -0300, Marcelo Tosatti wrote:
> > Here goes -rc8. If nothing really bad happens in 2 days, this becomes
> > final.
>
> Ugh, no fix for nfs_unlink/sillyrename?

Damn, right. I'll take a look at it and release -rc9 today or wait for
2.4.22pre.
