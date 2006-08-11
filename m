Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWHKRHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWHKRHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 13:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWHKRHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 13:07:42 -0400
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:58831 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S1751197AbWHKRHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 13:07:42 -0400
Message-ID: <44DCB95B.4060101@tremplin-utc.net>
Date: Fri, 11 Aug 2006 19:07:39 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060804)
MIME-Version: 1.0
To: Steve Barnhart <stb52988@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bootsplash integration
References: <15ce3ec0608110736y5ef185e8v6acd4f7556adcc49@mail.gmail.com>	 <6bffcb0e0608110752v3c4a7ac3xa87739163a411a27@mail.gmail.com> <15ce3ec0608110839i586e6f5cj3fd448aeddf4cddb@mail.gmail.com>
In-Reply-To: <15ce3ec0608110839i586e6f5cj3fd448aeddf4cddb@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

08/11/2006 05:39 PM, Steve Barnhart wrote/a écrit:
> I am aware of Splashy and it does seem rather nice, but I also am for
> several alternatives and Bootsplash has been around for a long time
> and gensplash continues to enhance it. SuSE has used bootsplash
> forever and mandrake does also I believe. It would be nice to finally
> have one of those actually integrated into the kernel since the
> technology and patches to do so are already there. It requires less
> work out of people like me ha and would be a nice feature addition in
> addition to good alternatives like splashy.
> 

The kernel only incorporates what is _really_ necessary. A jpeg decoder 
and a progress bar manager would never become part of the kernel! 
splashy proves that this kind of feature are absolutely not necessary in 
the kernel as it's feasible in the user-space. Move to splashy, it'll 
require you less work than patching your kernel ;-)

I just wonder if one can also put background pictures on the TTY only 
from user-space...

See you,
Eric

