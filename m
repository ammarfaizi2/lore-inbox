Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVCGQPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVCGQPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 11:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVCGQPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 11:15:39 -0500
Received: from adsl-346.mirage.euroweb.hu ([193.226.239.90]:22922 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261820AbVCGQPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 11:15:37 -0500
To: dhowells@redhat.com
CC: akpm@osdl.org, torvalds@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org
In-reply-to: <24862.1110211603@redhat.com> (message from David Howells on Mon,
	07 Mar 2005 16:06:43 +0000)
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
References: <E1D8KPt-00058Y-00@dorka.pomaz.szeredi.hu>  <E1D8K3T-00056q-00@dorka.pomaz.szeredi.hu> <20050307041047.59c24dec.akpm@osdl.org> <20050307034747.4c6e7277.akpm@osdl.org> <20050307033734.5cc75183.akpm@osdl.org> <20050303123448.462c56cd.akpm@osdl.org> <20050302135146.2248c7e5.akpm@osdl.org> <20050302090734.5a9895a3.akpm@osdl.org> <9420.1109778627@redhat.com> <31789.1109799287@redhat.com> <13767.1109857095@redhat.com> <9268.1110194624@redhat.com> <9741.1110195784@redhat.com> <9947.1110196314@redhat.com> <22447.1110204304@redhat.com> <24382.1110210081@redhat.com> <24862.1110211603@redhat.com>
Message-Id: <E1D8Ksv-0005Br-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 07 Mar 2005 17:15:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, yes. Obvious. Ugh. Andrew Morton suggested flipping the logic, and
> although it was in conjunction with turning the concepts into bitfields, it
> still stands here.

OK, obviously Andrew has the final word in this.  I just suggested
that it might be safer to have the logic flipped back.

Miklos
