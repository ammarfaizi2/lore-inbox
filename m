Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTAJQYD>; Fri, 10 Jan 2003 11:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTAJQYA>; Fri, 10 Jan 2003 11:24:00 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:33052 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S265277AbTAJQX7>; Fri, 10 Jan 2003 11:23:59 -0500
Date: Fri, 10 Jan 2003 16:34:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andi Kleen <ak@suse.de>, Daniel Ritz <daniel.ritz@gmx.ch>,
       <linux-kernel@vger.kernel.org>, <daniel.ritz@alcatel.ch>,
       Robert Love <rml@tech9.net>
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
In-Reply-To: <20030110161328.GV23814@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0301101628460.1434-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, William Lee Irwin III wrote:
> At some point in the past, I wrote:
> >> So the end-result of the discussion is, "What should really happen here?"
> >> and "What, if anything, do you want me to do?"
> 
> On Fri, Jan 10, 2003 at 05:12:12PM +0100, Andi Kleen wrote:
> > IMHO best would be to get rid of /proc/*/wchan and keep the kallsyms 
> > lookup slow, simple and stupid.
> 
> Slow, simple, and stupid == "wli, get the Hell out". I'm gone.

Indeed!  I think that was Andi volunteering :-}
But we should let rml defend his wchan.

Hugh

