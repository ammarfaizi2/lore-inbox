Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273619AbRJJF62>; Wed, 10 Oct 2001 01:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRJJF6S>; Wed, 10 Oct 2001 01:58:18 -0400
Received: from unthought.net ([212.97.129.24]:27868 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S273619AbRJJF6G>;
	Wed, 10 Oct 2001 01:58:06 -0400
Date: Wed, 10 Oct 2001 07:58:36 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: "Oleg A. Yurlov" <kris@spylog.com>
Cc: linux-kernel@vger.kernel.org, admin@spylog.com
Subject: Re: Re[2]: RAID sync
Message-ID: <20011010075836.A22084@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	"Oleg A. Yurlov" <kris@spylog.com>, linux-kernel@vger.kernel.org,
	admin@spylog.com
In-Reply-To: <1101445461994.20011001182753@spylog.com> <20011002071949.B5302@unthought.net> <129371054468.20011009233240@spylog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <129371054468.20011009233240@spylog.com>; from kris@spylog.com on Tue, Oct 09, 2001 at 11:32:40PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 11:32:40PM +0400, Oleg A. Yurlov wrote:
> 
>         Hi, Jakob and all,
...
> 
> JØ> Synchronization is a background operation - your array is functional
> JØ> immediately.
> 
>         No,  synchronization  not  started,  /proc/mdstat  say  that  RAID is Ok
> ([UU]). /proc/mdstat checked immediately after booting.
> 
> JØ> (this behaviour was changed from the really really old RAID code in unpatched
> JØ>  2.2 to standard 2.4)
> 
>         Neil already has given some explanations...

I was too quick, and as far as I can see, Neil gave the correct explanation.

Hey, maybe I was wrong, but I was *faster*   ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
