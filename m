Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274093AbRISPQN>; Wed, 19 Sep 2001 11:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274089AbRISPQE>; Wed, 19 Sep 2001 11:16:04 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47119 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274094AbRISPQA>;
	Wed, 19 Sep 2001 11:16:00 -0400
Date: Wed, 19 Sep 2001 12:16:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
In-Reply-To: <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz>
Message-ID: <Pine.LNX.4.33L.0109191215180.4279-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, [iso-8859-2] Martin MOKREJ© wrote:

>   I tried 2.4.10-pre12

> I have to say I've been using for a week without any "0-order allocation
> failed" patch from Marcelo. Now I see am back to the old stage. ;(

Impossible, the VM code which is in 2.4.10-pre11 and newer
wasn't published until sunday night, so you can't have been
using it for a week already. ;)

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

