Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbTAZAbe>; Sat, 25 Jan 2003 19:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbTAZAbe>; Sat, 25 Jan 2003 19:31:34 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:18832 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265754AbTAZAbe>; Sat, 25 Jan 2003 19:31:34 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 25 Jan 2003 16:46:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.21-pre3-jam3
In-Reply-To: <20030126003309.GG1507@werewolf.able.es>
Message-ID: <Pine.LNX.4.50.0301251645170.1855-100000@blue1.dev.mcafeelabs.com>
References: <20030126003309.GG1507@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2003, J.A. Magallon wrote:

> - 32-epoll-0.61.bz2
>     Improved polling interface via sys_epoll call. Faster, lighter and
>     more scalable.
>     Author: Davide Libenzi <davidel@xmailserver.org>
> - 33-epoll-smbfs
>     Fix for smbfs.

I just found the same error on ncpfs. Same fix though. I'll post the patch
asap.



- Davide

