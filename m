Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSHFRvL>; Tue, 6 Aug 2002 13:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSHFRvL>; Tue, 6 Aug 2002 13:51:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27919 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S314529AbSHFRvK>; Tue, 6 Aug 2002 13:51:10 -0400
Date: Tue, 6 Aug 2002 14:04:18 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Pawel Kot <pkot@linuxnews.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] add missing symbol exports
In-Reply-To: <Pine.LNX.4.33.0208060815400.24592-100000@bzzzt.slackware.pl>
Message-ID: <Pine.LNX.4.44.0208061403580.7534-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Aug 2002, Pawel Kot wrote:

> Hi,
>
> During the work on the NTFS backport I found that some sympols are missing
> in ksyms exports. The following patch add the missing symbols. This is
> against 2.4.19, as I can't find 2.4.20pre1 patch anywhere.

Missing as in "used by the NTFS backport" ?



