Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSC2TeU>; Fri, 29 Mar 2002 14:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293196AbSC2TeL>; Fri, 29 Mar 2002 14:34:11 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:13323 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293060AbSC2Td7>;
	Fri, 29 Mar 2002 14:33:59 -0500
Date: Fri, 29 Mar 2002 16:33:44 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request for 2.4.20 to be a non-trivial-bugfixes-only version
In-Reply-To: <5.1.0.14.0.20020329101556.0188aea8@mailhost.ivimey.org>
Message-ID: <Pine.LNX.4.44L.0203291632550.18660-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002, Ruth Ivimey-Cook wrote:

> Can we celebrate getting to 2.4.20 with a really super-stable version of
> the kernel, by only admitting patches that fix known and significant
> bugs (that is, no new features, no more optimisations, no backports, no
> "it's only a line" fixes)?
>
> It would help 2.4 a lot, I think.

Not correct, you cannot have bugfixes-only if there are still
large structural things which need changes to work right on
some machines, eg. the VM.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

