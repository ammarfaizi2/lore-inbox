Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135336AbRDZLuZ>; Thu, 26 Apr 2001 07:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135339AbRDZLuP>; Thu, 26 Apr 2001 07:50:15 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:25805 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S135336AbRDZLuA>; Thu, 26 Apr 2001 07:50:00 -0400
Date: Thu, 26 Apr 2001 12:50:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: 2.4.3 tinny module interface cleanum
In-Reply-To: <20010426114700.A679@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.21.0104261248560.1410-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Ingo Oeser wrote:
> On Thu, Apr 26, 2001 at 10:58:46AM +0200, Martin Dalecki wrote:
> > 1. Help making the module interface cleaner by a tinny margin :-).
> 
> You only help changing the API during a stable[1] series. Wait until 2.5
> for this.
> 
> API cannot change during stable series. (ABI can, BTW)
> 
> So lets just forget about this, ok ;-)

Wrong answer: AV already did it (static get_empty_super) in 2.4.4-pre4.

Hugh

