Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268530AbTGIS1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268533AbTGIS1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:27:30 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:26630 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S268530AbTGIS12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:27:28 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: trond.myklebust@fys.uio.no, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ->direct_IO API change in current 2.4 BK
Date: Wed, 9 Jul 2003 20:41:42 +0200
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20030709133109.A23587@infradead.org> <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva> <16140.24595.438954.609504@charged.uio.no>
In-Reply-To: <16140.24595.438954.609504@charged.uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307092041.42608.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 July 2003 20:33, Trond Myklebust wrote:

Hi Trond,

> >>>>> " " == Marcelo Tosatti <marcelo@conectiva.com.br> writes:
>      > Ok, right. Well, I dont know why it doesnt happen there. Maybe
>      > not enough testing?
> Probably nobody is applying the XFS patches on those kernel?
err, -aa has XFS per default, -wolk has XFS per default. So ... ;)

ciao, Marc

