Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWE3V6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWE3V6e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWE3V6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:58:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:57251 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932512AbWE3V6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:58:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fs8pO6g1aqqK8Ko+j53KQuVmC6GKDSN5wQLguDd5IAsgcant3b/UD4TroI8QXbIqYSkFjMbbMaDfR6m1uQrmFRDwOQKT6OF0kkxdtpDxTS6U0MHZTDSEgONKBJS/zxgnLnPAc5R/5y0M3p7jy3lO41SYoA7juk0rInkHvvYLKbw=
Message-ID: <4d8e3fd30605301458h33fc5e47t5c6f35bc08f2b545@mail.gmail.com>
Date: Tue, 30 May 2006 23:58:32 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Cc: "Roland Dreier" <rdreier@cisco.com>, "Dave Jones" <davej@redhat.com>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       nanhai.zou@intel.com
In-Reply-To: <20060530204123.GA27436@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com>
	 <20060529230908.GC333@redhat.com>
	 <1148967947.3636.4.camel@laptopd505.fenrus.org>
	 <20060530141006.GG14721@redhat.com>
	 <1148998762.3636.65.camel@laptopd505.fenrus.org>
	 <20060530145852.GA6566@redhat.com>
	 <20060530171118.GA30909@dominikbrodowski.de>
	 <20060530190235.GC17218@redhat.com> <adafyir71sm.fsf@cisco.com>
	 <20060530204123.GA27436@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Roland Dreier <rdreier@cisco.com> wrote:
>
> >     Dave> I was hoping you could enlighten me :) I started picking
> >     Dave> through history with gitk, but my tk install uses fonts that
> >     Dave> make my eyes bleed.  My kingdom for a 'git annotate'..
> >
> > Heh -- try "git annotate" or "git blame".  I think you need git 1.3.x
> > for that... details of where to send your kingdom forthcoming...
>
> i use qgit, which is GTK based and thus uses the native desktop fonts.

GTK? A typo, I suppose.
QGit is a git GUI viewer built on Qt/C++ (that I hope will be added to
the git.git tree soon).

Ciao,

-- 
Paolo
http://paolociarrocchi.googlepages.com
