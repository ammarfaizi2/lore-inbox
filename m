Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315952AbSEGT1f>; Tue, 7 May 2002 15:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315953AbSEGT1e>; Tue, 7 May 2002 15:27:34 -0400
Received: from pc132.utati.net ([216.143.22.132]:28063 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S315952AbSEGT1c>; Tue, 7 May 2002 15:27:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Lars Marowsky-Bree <lmb@suse.de>, Jeff Dike <jdike@karaya.com>
Subject: Re: [uml-devel] Re: UML is now self-hosting!
Date: Tue, 7 May 2002 09:29:04 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
In-Reply-To: <20020506181427.K918@marowsky-bree.de> <200205062055.PAA04067@ccure.karaya.com> <20020507182620.U2539@marowsky-bree.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020507195147.4A3DD749@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 May 2002 12:26 pm, Lars Marowsky-Bree wrote:

> > This machine thinks it's a normal SMP box, so scheduling happens as
> > normal
>
> Ugh ugh ugh. Too many page faults; you need a scheduler capable of keeping
> node affinity.

O(1)?

Thought it did.  Might have to teach the load balancer to be a bit more 
clever...

Rob
