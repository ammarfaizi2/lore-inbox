Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbTCaX2r>; Mon, 31 Mar 2003 18:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbTCaX2r>; Mon, 31 Mar 2003 18:28:47 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:50335 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S261910AbTCaX2r>;
	Mon, 31 Mar 2003 18:28:47 -0500
Date: Mon, 31 Mar 2003 16:27:47 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: TIOCTTYGSTRUCT
Message-ID: <20030331212747.GA1840@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <UTC200303281549.h2SFnkw05009.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200303281549.h2SFnkw05009.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 04:49:46PM +0100, Andries.Brouwer@cwi.nl wrote:
> Hi Ted,
> 
> Would you mind if I removed TIOCTTYGSTRUCT?
> 
> I suppose you don't need it any longer, and otherwise
> could easily add some debugging stuff again when needed.
> This ioctl exports lots of kernel-internal stuff that
> userspace has no business looking at.

Sure, go ahead; I'm pretty sure no one has used it for at least 6-7
years...

						- Ted
