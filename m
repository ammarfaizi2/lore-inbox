Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbSKGCCo>; Wed, 6 Nov 2002 21:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbSKGCCo>; Wed, 6 Nov 2002 21:02:44 -0500
Received: from pc132.utati.net ([216.143.22.132]:48257 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S266285AbSKGCCn> convert rfc822-to-8bit; Wed, 6 Nov 2002 21:02:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: "Guillaume Boissiere" <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  November 6, 2002
Date: Wed, 6 Nov 2002 21:06:44 +0000
User-Agent: KMail/1.4.3
References: <3DC9402F.22787.27763DD6@localhost>
In-Reply-To: <3DC9402F.22787.27763DD6@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211062106.44205.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 November 2002 21:15, Guillaume Boissiere wrote:
> With Halloween behind us, I have regrouped all the remaining items on
> the status list into 2 categories: 2.6 and post-2.6.
> I'd be great if folks in the know could comment on the relevance of
> the breakdown!
>
> The full list is at http://www.kernelnewbies.org/status/
> Enjoy!

Does your "in 2.6" category mean during the 2.6-pre stage?  I doubt James 
Simmons's console layer rewrite would be dropped in between 2.6.3 and 2.6.4.  
It might still go in because it was submitted by deadline and Linus still 
seems to be chewing through the backlog a bit, but that does strike me as 
something that people would want a crack at during the stabilization phase 
(the 2.6-pre kernels).  But I think it has to be before 2.6.0.  (I think.)

Ditto for the IPV6 rewrite, the people who are currently using IPV6 may want a 
bit of warning about it.  (Unless they're going to do a new/old configuration 
option nightmare thing, which seems really unlikely...)

> o in 2.6  32bit dev_t  (?)

I suspect this got bumped to 2.7, but haven't heard a thing about it from Alan 
or Al.  Again, not a "during 2.6" item (that I know of), but that's just a 
guess.

Of course since it's coming from Al, he may not bother CCing the list and just 
send it straight to Linus.  He's one of the few people who can get away with 
that.  (And vi script patches.  He seems to have a personality that scares 
bugs away...)

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
