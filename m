Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279381AbRJWLdm>; Tue, 23 Oct 2001 07:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279380AbRJWLdc>; Tue, 23 Oct 2001 07:33:32 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:44043 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S279378AbRJWLda>;
	Tue, 23 Oct 2001 07:33:30 -0400
Date: Tue, 23 Oct 2001 09:33:41 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: safemode <safemode@speakeasy.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: time tells all about kernel VM's
In-Reply-To: <20011023030353Z279218-17408+3723@vger.kernel.org>
Message-ID: <Pine.LNX.4.33L.0110230933000.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, safemode wrote:

> A.  OOM did not kick in and kill kghostview.  Why you may ask?  Read on to B.
> B.  ....  So what
> happens is that the kernel cant swap because the hdd io is being strangled by
> the process that's going out of control (kghostview) which means that the VM
> is stuck doing this redistribution at a snails pace and the OOM situation
> never occurs

> I see this as a pretty serious bug

Fully agreed. Fixes are welcome.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

