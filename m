Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273794AbRI0S3F>; Thu, 27 Sep 2001 14:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273795AbRI0S2z>; Thu, 27 Sep 2001 14:28:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:51462 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273794AbRI0S2q>;
	Thu, 27 Sep 2001 14:28:46 -0400
Date: Thu, 27 Sep 2001 15:28:51 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <laughing@shared-source.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.9-ac16
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L.0109271523080.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, Alan Cox wrote:

> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/

> *	Update the VM to Rik's latest bits

> 2.4.9-ac16
> o	Fix VM breakage from my merge error		(Rik van Riel)

... which I didn't notice until I tried to merge an unrelated
patch for our kernel RPM yesterday.

This certainly explains the bad reports some people have sent
in about 2.4.9-ac15 ;)

Because of the now correct merge, I'm _very_ interested in
any test results with this VM.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

