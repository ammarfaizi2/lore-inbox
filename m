Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290079AbSAQRcr>; Thu, 17 Jan 2002 12:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290081AbSAQRc1>; Thu, 17 Jan 2002 12:32:27 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:33543 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290079AbSAQRcY>;
	Thu, 17 Jan 2002 12:32:24 -0500
Date: Thu, 17 Jan 2002 15:31:58 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Christoph Rohland <cr@sap.com>
Cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <m3bsft7ygd.fsf@linux.local>
Message-ID: <Pine.LNX.4.33L.0201171531420.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Christoph Rohland wrote:

> Another case are smaller machines with big tmpfs instances: They get
> killed by the swap entries. But you cannot hinder that without
> swapping the swap entries themselves.

I wonder how hard this would be to do ... ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

