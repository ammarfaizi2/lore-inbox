Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWHNVbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWHNVbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWHNVbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:31:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964973AbWHNVbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:31:32 -0400
Date: Mon, 14 Aug 2006 14:31:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060814143110.f62bfb01.akpm@osdl.org>
In-Reply-To: <10791.1155580339@warthog.cambridge.redhat.com>
References: <20060813133935.b0c728ec.akpm@osdl.org>
	<20060813012454.f1d52189.akpm@osdl.org>
	<10791.1155580339@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 19:32:19 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > sony:/home/akpm> showmount -e bix
> > Export list for bix:
> > /           *
> > /usr/src    *
> > /mnt/export *
> 
> What's in your /etc/exports file?
> 

bix:/home/akpm> cat /etc/exports
/               *(rw,async)
/usr/src        *(rw,async)
/mnt/export     *(rw,async)

