Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTEEOjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTEEOjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:39:47 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:54662 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP id S262282AbTEEOjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:39:46 -0400
Date: Mon, 5 May 2003 16:53:12 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein31.homenet
To: Arjan van de Ven <arjanv@redhat.com>
cc: Terje Eggestad <terje.eggestad@scali.com>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, <D.A.Fedorov@inp.nsk.su>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030505113330.B8615@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0305051650270.1045-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003, Arjan van de Ven wrote:

> On Mon, May 05, 2003 at 01:31:19PM +0200, Terje Eggestad wrote:
> > In all fairness this should be done in glibc,
> 
> ... or a LD_PRELOAD library......

which doesn't work with statically linked binaries, does it?

Regards
Tigran

