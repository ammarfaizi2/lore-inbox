Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSBOMxn>; Fri, 15 Feb 2002 07:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288960AbSBOMxd>; Fri, 15 Feb 2002 07:53:33 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.25]:40537 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S288967AbSBOMxX>; Fri, 15 Feb 2002 07:53:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 2.5.5-pre1: Deadlocks and ALSA driver problems
Date: Fri, 15 Feb 2002 13:53:39 +0100
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
In-Reply-To: <Pine.LNX.4.31.0202151311120.608-200000@pnote.perex-int.cz>
In-Reply-To: <Pine.LNX.4.31.0202151311120.608-200000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020215124929.XEKK19167.amsfep16-int.chello.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 February 2002 13:12, Jaroslav Kysela wrote:
>
> Attached patch for linux/sound/core/info.c fixes the problem with /proc
> entries.
>

Confirmed.  /proc interface seems working as expected. 

Jos
 

