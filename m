Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbSJBKcf>; Wed, 2 Oct 2002 06:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263033AbSJBKcf>; Wed, 2 Oct 2002 06:32:35 -0400
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:29861 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id <S263031AbSJBKce>; Wed, 2 Oct 2002 06:32:34 -0400
Date: Wed, 2 Oct 2002 12:38:02 +0200
From: GOMBAS Gabor <gombasg@inf.elte.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] default file permission for vfat
Message-ID: <20021002103802.GC1099@boogie.lpds.sztaki.hu>
References: <20021001173908.GA15838@atrey.karlin.mff.cuni.cz> <20021001185526.GA704@alpha.home.local> <3D9AB638.60209@corvil.com> <20021002094612.GA2587@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002094612.GA2587@alpha.home.local>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 11:46:12AM +0200, Willy Tarreau wrote:

> not when you want your customers to be able to edit their firewall config
> with their M$ PC !

Copy them to tmpfs, do "chmod +x", execute them.

Gabor

-- 
Gabor Gombas                                       Eotvos Lorand University
E-mail: gombasg@inf.elte.hu                        Hungary
