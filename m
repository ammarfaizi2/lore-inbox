Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbRDOACx>; Sat, 14 Apr 2001 20:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132559AbRDOACn>; Sat, 14 Apr 2001 20:02:43 -0400
Received: from mx2out.umbc.edu ([130.85.253.52]:63963 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S132558AbRDOACh>;
	Sat, 14 Apr 2001 20:02:37 -0400
Date: Sat, 14 Apr 2001 20:02:34 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Marko Kreen <marko@l-t.ee>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Thorsten Glaser Geuer <eccesys@topmail.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Still cannot compile, 2.4.3-ac6
In-Reply-To: <20010415005624.A11455@l-t.ee>
Message-ID: <Pine.SGI.4.31L.02.0104142001070.3779138-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Apr 2001, Marko Kreen wrote:

> Sorry.  Who said it should not be tested?  How else it could get
> 'default compiler'?  If the gcc-3.0 would start giving errors
> on some old code then it could be gcc bug.  But this rwsem code
> is couple of days old.  It is good to let it through stricter
> error checking, I guess.  This rwsem is very in-flux code.  eg.
> 2.4.4-pre2 did not compile.  ac[56] with um-arch do not compile.

For what its worth, I got the same error on 2.4.3-ac5, using gcc 2.91.66.

I did seem messages fly by in on the list about a few in -ac5, but
haven't gone back to dig them out.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

