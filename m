Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271220AbTHLXPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 19:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271224AbTHLXPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 19:15:15 -0400
Received: from uns-y1.unisinos.br ([200.188.162.1]:44938 "EHLO
	sav03.unisinos.br") by vger.kernel.org with ESMTP id S271220AbTHLXPM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 19:15:12 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: 2.4.21 + Reiserfs + NFS oops
Date: Tue, 12 Aug 2003 20:13:05 -0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200308121440.24983.lucasvr@gobolinux.org> <20030812233256.21c80830.skraw@ithnet.com>
In-Reply-To: <20030812233256.21c80830.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308122013.05655.lucasvr@gobolinux.org>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 06:32 pm, Stephan von Krawczynski wrote:
> On Tue, 12 Aug 2003 14:40:24 -0300
>
> Lucas Correia Villa Real <lucasvr@gobolinux.org> wrote:
> > Hi,
> >
> > I have been trying to export an reiserfs partition on NFS. I can mount it
> > remotely and even create files on it, but I always got a kernel oops when
> > trying to remove any file. I have also tryied to export another
> > partition, formatted as ext2 (but keeping my root fs as reiserfs), but
> > the problem has persisted.
>
> Have you tried to compile your kernel with another compiler (i.e. not gcc
> 3.2.X) ?

Not yet. I will try with 2.9x tomorrow.

Thanks,
Lucas

