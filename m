Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265271AbSJXARs>; Wed, 23 Oct 2002 20:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265272AbSJXARs>; Wed, 23 Oct 2002 20:17:48 -0400
Received: from pc132.utati.net ([216.143.22.132]:43393 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S265271AbSJXARn> convert rfc822-to-8bit; Wed, 23 Oct 2002 20:17:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: "Guillaume Boissiere" <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  October 23, 2002
Date: Wed, 23 Oct 2002 14:23:50 -0500
User-Agent: KMail/1.4.3
References: <3DB60107.24661.691E895D@localhost>
In-Reply-To: <3DB60107.24661.691E895D@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210231423.50073.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 October 2002 00:53, Guillaume Boissiere wrote:
> Only a couple days to go before feature freeze.
> And many changes since last week... due in large part
> to recent discussions about what "mergeable" means.
>
> The Web version is as usual at:
>   http://www.kernelnewbies.org/status/
>
> The list should map pretty closely to the latest
> Crunch Time list sent out by Rob.
>
> Enjoy!
>
> -- Guillaume

Oh fun, more work. :)

I can't figure out which specific patch you mean by "per-cpu hot and cold page 
lists" (there's a half-dozen candidates, closest seems to be adding a tag to 
pagevec, maybe I just missed it?)  And since there doesn't seem to be any API 
change, this might possibly be able to go into the stable series?  (Does it 
break other stuff?)

People keep telling me zerocopy NFS is already in, you've got it in the ready 
state...

I think a proper explanation of the chances of the digital video project 
getting in from a standing start at this late date involve snowballs and 
theology, but you never know, and it's not my call... :)

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
