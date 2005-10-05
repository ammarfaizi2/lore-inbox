Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVJEMHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVJEMHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbVJEMHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:07:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21936 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965134AbVJEMHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:07:19 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1128513630.2920.25.camel@laptopd505.fenrus.org> 
References: <1128513630.2920.25.camel@laptopd505.fenrus.org>  <1128510159.2920.15.camel@laptopd505.fenrus.org> <OF7208B0E9.0AB77A04-ON87257090.007A1D4E-05257090.007A2207@us.ibm.com> <28129.1128509939@warthog.cambridge.redhat.com> <29094.1128512432@warthog.cambridge.redhat.com> 
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       Michael C Thompson <mcthomps@us.ibm.com>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Export user-defined keyring operations 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 05 Oct 2005 13:06:57 +0100
Message-ID: <29858.1128514017@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:

> > > since this is new unique-to-linux functionality, could you please
> > > consider making the exports _GPL please?
> > 
> > I have.
> 
> the patch doesn't show it though ;)

I have considered it.

> are there any users of this?

Potentially - I've been asked for it.

> Is this accidentally for an external non-GPL module???

No.

David
