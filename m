Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVCGVZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVCGVZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVCGVYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:24:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:43237 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261767AbVCGUPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:15:06 -0500
Date: Mon, 7 Mar 2005 12:14:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, torvalds@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
Message-Id: <20050307121416.78381632.akpm@osdl.org>
In-Reply-To: <E1D8Ksv-0005Br-00@dorka.pomaz.szeredi.hu>
References: <E1D8KPt-00058Y-00@dorka.pomaz.szeredi.hu>
	<E1D8K3T-00056q-00@dorka.pomaz.szeredi.hu>
	<20050307041047.59c24dec.akpm@osdl.org>
	<20050307034747.4c6e7277.akpm@osdl.org>
	<20050307033734.5cc75183.akpm@osdl.org>
	<20050303123448.462c56cd.akpm@osdl.org>
	<20050302135146.2248c7e5.akpm@osdl.org>
	<20050302090734.5a9895a3.akpm@osdl.org>
	<9420.1109778627@redhat.com>
	<31789.1109799287@redhat.com>
	<13767.1109857095@redhat.com>
	<9268.1110194624@redhat.com>
	<9741.1110195784@redhat.com>
	<9947.1110196314@redhat.com>
	<22447.1110204304@redhat.com>
	<24382.1110210081@redhat.com>
	<24862.1110211603@redhat.com>
	<E1D8Ksv-0005Br-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Sorry, yes. Obvious. Ugh. Andrew Morton suggested flipping the logic, and
> > although it was in conjunction with turning the concepts into bitfields, it
> > still stands here.
> 
> OK, obviously Andrew has the final word in this.  I just suggested
> that it might be safer to have the logic flipped back.
> 

Experience indicates that it's safer to ignore anything I say on this topic.

Yeah, it would be better to not flip the logic.
