Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSBRVxO>; Mon, 18 Feb 2002 16:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288005AbSBRVxF>; Mon, 18 Feb 2002 16:53:05 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:6919 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287933AbSBRVwt>;
	Mon, 18 Feb 2002 16:52:49 -0500
Date: Mon, 18 Feb 2002 18:52:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-rc2
In-Reply-To: <Pine.LNX.4.21.0202181815480.25479-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0202181851080.1930-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Marcelo Tosatti wrote:

> Well hopefully have a 2.4.18 pretty soon..
>
> rc2:
> - Make get_user_pages handle VM_IO areas
>   gracefully					(Manfred Spraul)
> - Fix SMP race on PID allocation		(Erik A. Hendriks)
> - Fix SMP race on dnotify scheme		(Alexander Viro)
> - Add missing checks to shmem_file_write	(Alan Cox)

I've just pushed this patch into my linux-2.4-vanilla
bitkeeper tree, which is available from:

	bk://linuxvm.bkbits.net/linux-2.4-vanilla/

Of course the changes are also browsable online, just
point your browser to the url using http ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

