Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270610AbTGNMl3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270625AbTGNMk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:40:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:32696 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270610AbTGNMid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:38:33 -0400
Date: Mon, 14 Jul 2003 09:50:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, marcelo@conectiva.com,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: -- END OF BLOCK --
In-Reply-To: <200307141239.h6ECdqXP002766@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307140947210.18257@freak.distro.conectiva>
References: <200307141239.h6ECdqXP002766@hraefn.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003, Alan Cox wrote:

>
> That ends the push of -ac contributions that want adding now.

I've applied some of the patches already, will keep looking at them now...

Thanks.

> There is a chunk of quota stuff that vanished with hch's merge that
> looks important as it avoids deadlocks in ext3. Perhaps Christoph can
> take a glance at the ext3/super differences and the related code ?

Christoph?

> I've resynched -ac to the quota code in pre5 and added the automatic
> quota loader on top again.

And the deadlock avoidance patches too right?

Would you mind sending me the automatic quota loader diff and the deadlock
avoidance diff ?


