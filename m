Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275353AbTHMTp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275355AbTHMTpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:45:55 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:26752 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275353AbTHMTpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:45:34 -0400
Date: Wed, 13 Aug 2003 20:44:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Larry McVoy <lm@bitmover.com>,
       davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030813194442.GH4405@mail.jlokier.co.uk>
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F37CF4E.3010605@pobox.com> <20030811172333.GA4879@work.bitmover.com> <3F37D80D.5000703@pobox.com> <20030812070007.A8269@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812070007.A8269@almesberger.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> <stmt> ::= if (<expression>) <stmt>
> <stmt> ::= { <newline> <stmts> } <newline>
> <stmt> ::= <expression> ; <newline>
> etc.
> 
> Perfectly consistent. ("Always end a statement with a newline.")

So you agree with Javascript that the semicolons aren't necessary :)

-- Jamie
