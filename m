Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290325AbSAPBR5>; Tue, 15 Jan 2002 20:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290319AbSAPBRu>; Tue, 15 Jan 2002 20:17:50 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:14094 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S290325AbSAPBRk>; Tue, 15 Jan 2002 20:17:40 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Jan 2002 17:23:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, John Weber <weber@nyc.rr.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <Pine.LNX.4.40.0201151710310.944-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.40.0201151722490.944-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Davide Libenzi wrote:

> Doh !
>
> Trace; c0113988 <schedule+118/2b0>
> Trace; c01075cd <sys_clone+1d/30>
> Trace; c0105020 <init+0/140>
> Trace; c0105000 <_stext+0/0>
> Trace; c010720d <kernel_thread+1d/30>
> Trace; c0105011 <rest_init+11/20>
>
> Let me try something ...

Ehmmm, let's do like if nothing happened :-)




- Davide


