Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291040AbSAaM1j>; Thu, 31 Jan 2002 07:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291041AbSAaM13>; Thu, 31 Jan 2002 07:27:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7088 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291040AbSAaM1Z>;
	Thu, 31 Jan 2002 07:27:25 -0500
Date: Thu, 31 Jan 2002 07:27:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Molnar <mingo@elte.hu>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201311515350.9106-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0201310725540.15689-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Jan 2002, Ingo Molnar wrote:

> 'old' architectures do not hinder development - they are separate, and
> they have to update their stuff. (and i think the m68k port is used by

... unless they play silly buggers with the internals of VM.

