Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264911AbRFZMnz>; Tue, 26 Jun 2001 08:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264913AbRFZMnp>; Tue, 26 Jun 2001 08:43:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:27911 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264912AbRFZMn0>;
	Tue, 26 Jun 2001 08:43:26 -0400
Date: Tue, 26 Jun 2001 09:43:20 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Cc: linux-kernel@vger.kernel.org, urban@svenskatest.se
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state
In-Reply-To: <20010626092056.20372.qmail@theseus.mathematik.uni-ulm.de>
Message-ID: <Pine.LNX.4.21.0106260942520.7419-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2001, Christian Ehrhardt wrote:

> > I've seen this under UML, Rik van Riel has seen it on a physical box, and we 
> > suspect that they're the same problem (i.e. mine isn't a UML-specific bug).
> 
> Could it be smbfs?

No. I've seen the hang on pure ex2.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

