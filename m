Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318163AbSGWRkV>; Tue, 23 Jul 2002 13:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318164AbSGWRkV>; Tue, 23 Jul 2002 13:40:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3267 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318163AbSGWRkV>;
	Tue, 23 Jul 2002 13:40:21 -0400
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
From: Paul Larson <plars@austin.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, haveblue@us.ibm.com
In-Reply-To: <20020722225251.GG919@holomorphy.com>
References: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com>
	<1027377273.5170.37.camel@plars.austin.ibm.com> 
	<20020722225251.GG919@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Jul 2002 12:40:43 -0500
Message-Id: <1027446044.7699.15.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 17:52, William Lee Irwin III wrote:
> ISTR this compiler having code generation problems. I think trying to
> reproduce this with a working i386 compiler is in order, e.g. debian's
> 2.95.4 or some similarly stable version.
That's exactly the one I was planning on trying it with.  Tried it this
morning with the same error.  Three compilers later, I think this is
looking less like a compiler error.  Any ideas?

-Paul Larson

