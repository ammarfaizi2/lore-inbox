Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314087AbSDVIeZ>; Mon, 22 Apr 2002 04:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314088AbSDVIeY>; Mon, 22 Apr 2002 04:34:24 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6207 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314087AbSDVIeY>; Mon, 22 Apr 2002 04:34:24 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200204220834.g3M8YJB03362@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.19pre7-ac2
To: hch@infradead.org (Christoph Hellwig)
Date: Mon, 22 Apr 2002 04:34:19 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020420130430.A10808@infradead.org> from "Christoph Hellwig" at Apr 20, 2002 01:04:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Apr 19, 2002 at 08:38:05PM -0400, Alan Cox wrote:
> > o	Put syscall table back for now			(Steven Hirsch)
> 
> Why?

Because several profiling tools have quite reasonable uses for it that
need sorting out properly ..

