Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVLNLNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVLNLNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLNLNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:13:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49124 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932093AbVLNLNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:13:18 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <13820.1134558138@warthog.cambridge.redhat.com> 
References: <13820.1134558138@warthog.cambridge.redhat.com>  <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com> <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu> <20051213100015.GA32194@elte.hu> <6281.1134498864@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Paul Jackson <pj@sgi.com>, mingo@elte.hu, hch@infradead.org, akpm@osdl.org,
       torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 14 Dec 2005 11:12:52 +0000
Message-ID: <14242.1134558772@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> 
>  (6) Make wrappers for up/down that map to counting semaphores with the
>      deprecation attribute set.

 (7) After a couple of months, remove up and down entirely.

David
