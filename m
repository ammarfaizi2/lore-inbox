Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269020AbUJENck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269020AbUJENck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUJENck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:32:40 -0400
Received: from smtp.nedstat.nl ([194.109.98.184]:20928 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S269020AbUJENci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:32:38 -0400
Subject: Re: 2.6.9-rc3-mm2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: Pasi Savolainen <psavo@iki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0410051251210.6757-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0410051251210.6757-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1096982938.3172.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Oct 2004 15:28:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 14:06, Hugh Dickins wrote:
> On Tue, 5 Oct 2004, Peter Zijlstra wrote:
> > On Mon, 2004-10-04 at 19:13, Pasi Savolainen wrote:
> > >   LD      .tmp_vmlinux1
> > >   KSYM    .tmp_kallsyms1.S
> > > make: *** wait: No child processes.  Stop.
> > > - -
> > > The 'no child processes' keeps on coming up at 'random' moments under
> > > rc3-mm1. First time ever that I've seen it otherwise.
> > 
> > Just a simple mee too!
> > on 2.6.9-rc3-mm2-VP-T0 and on some earlier Sx patches as well.
> > Unfortunatly I haven't had time to track back as to when this was
> > introduced.
> 
> Please, would you try this patch below that I posted yesterday?
> At the time I thought the trylock was hardly used so not urgent.
> 
So far, so good!

you rule!


 Peter Zijlstra

