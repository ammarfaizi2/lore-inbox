Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261882AbSJNLEB>; Mon, 14 Oct 2002 07:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSJNLEB>; Mon, 14 Oct 2002 07:04:01 -0400
Received: from [66.70.28.20] ([66.70.28.20]:20744 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S261882AbSJNLDX>; Mon, 14 Oct 2002 07:03:23 -0400
Date: Mon, 14 Oct 2002 13:04:35 +0200
From: DervishD <raul@pleyades.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] mmap.c (do_mmap_pgoff), against 2.4.19 and 2.4.20-pre10
Message-ID: <20021014110435.GD381@DervishD>
References: <20021014093622.GA96@DervishD> <20021014.025250.105171520.davem@redhat.com> <20021014102042.GC96@DervishD> <20021014.034447.127180554.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021014.034447.127180554.davem@redhat.com>
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    > I bet if you explain this, Marcelo will take your fix.
>        Marcelo told me to resend this patch at 2.4.20-pre time,
> Thanks for describing your fix all over again, and I hope
> this leads Marcelo to inspect your fix more closely :)

    The patch is very stupid, just as the bug ;)) Really is only one
line added and another one moved ;)) I hope this time the patch is
ok. I've resent it with the suggestions from Russell King :)

    Raúl
