Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270486AbTHQSbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 14:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270489AbTHQSbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 14:31:15 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21376 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270486AbTHQS3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 14:29:48 -0400
Date: Sun, 17 Aug 2003 19:29:36 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030817182936.GC2822@mail.jlokier.co.uk>
References: <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net> <5.2.1.1.2.20030817100457.019d0c70@pop.gmx.net> <5.2.1.1.2.20030817195509.019d2de8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030817195509.019d2de8@pop.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> This, and the continue my slice in some other thread thing is what
> made me think you'd have to deal with a schedule happening to your
> worker thread with some kind of handler, and do all kinds of evil
> things within... basically overloading the entire scheduler for that class.

Ew.  Very nasty.

-- Jamie
