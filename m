Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288733AbSAICun>; Tue, 8 Jan 2002 21:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288734AbSAICuc>; Tue, 8 Jan 2002 21:50:32 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:2575 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288733AbSAICuZ>;
	Tue, 8 Jan 2002 21:50:25 -0500
Date: Wed, 9 Jan 2002 00:49:56 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: can we make anonymous memory non-EXECUTABLE?
In-Reply-To: <a1gar7$12t$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0201090049390.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2002, H. Peter Anvin wrote:

> One way to do this would be to create a newbrk() syscall which takes a
> permission argument (for new pages.)

ITYM mmap(2)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

