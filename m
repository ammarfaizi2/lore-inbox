Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291166AbSBGPO2>; Thu, 7 Feb 2002 10:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291167AbSBGPOT>; Thu, 7 Feb 2002 10:14:19 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1543 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291166AbSBGPOH>;
	Thu, 7 Feb 2002 10:14:07 -0500
Date: Thu, 7 Feb 2002 13:13:54 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, <zaitcev@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The IBM order relaxation patch
In-Reply-To: <OFDEA688CD.7104528D-ONC1256B59.00522C09@de.ibm.com>
Message-ID: <Pine.LNX.4.33L.0202071313200.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Ulrich Weigand wrote:

> On s390 we have per physical page hardware referenced / changed bits.
> In the rmap framework, it should also be possible to make more
> efficient use of these ...

Absolutely, on S390 you could basically bypass part
of the -rmap code.

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

