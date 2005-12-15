Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbVLOTBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVLOTBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVLOTBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:01:09 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:55176 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750934AbVLOTBH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:01:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z0DfP3FdGEKB7eNK5pD1DnSKW29GLMZJuwnrG2euEkUid0axU+AFrdw8LSMqvXFoLbkBG/j3QEYv/EY2IOwl2GLnF0hIlRWcSk2g/ijGYm4PUcjBljL2iStF+5tY/kquA3pfuwIdENtbEclNGsqqPE2ugYyoI0Vx5hKq+enBZgQ=
Message-ID: <d120d5000512151101s31930563xb537616c7a712b1f@mail.gmail.com>
Date: Thu, 15 Dec 2005 14:01:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Al Boldi <a1426z@gawab.com>
Subject: Re: Linux in a binary world... a doomsday scenario
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200512152129.01861.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512150013.29549.a1426z@gawab.com>
	 <200512151131.39216.a1426z@gawab.com> <43A1501F.5070803@aitel.hist.no>
	 <200512152129.01861.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/05, Al Boldi <a1426z@gawab.com> wrote:
>
> Don't mistake scalability for manageability/mantainability or flexibility.
> Scalability is more, much more.  It's about extendability and reusability
> built on a solid foundation that may be stacked.  Layers upon layers, the
> sky is the limit.  Stability is the key to unlock this scalability.
>

There is a game, called "bullsh*t bingo" where you have bunch of
buzzwords on you scorecard and you cross them out as you sneak them in
conversation. Well, I think you just have won a round.

--
Dmitry
