Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRHEXIB>; Sun, 5 Aug 2001 19:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264669AbRHEXHv>; Sun, 5 Aug 2001 19:07:51 -0400
Received: from unthought.net ([212.97.129.24]:25573 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S264375AbRHEXHn>;
	Sun, 5 Aug 2001 19:07:43 -0400
Date: Mon, 6 Aug 2001 01:07:38 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wedgwood <cw@f00f.org>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps getting _VERY_ long
Message-ID: <20010806010738.B11372@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wedgwood <cw@f00f.org>,
	Rik van Riel <riel@conectiva.com.br>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010805171202.A20716@weta.f00f.org> <E15TNbk-0007pu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <E15TNbk-0007pu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Aug 05, 2001 at 02:06:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 02:06:16PM +0100, Alan Cox wrote:
> >     Ouch, what kind of application is this happening with ?
> > 
> > Mozilla.  Presumably some of the Gnome applications might be the same
> > as they use lots and lots of shared libraries (anyone out there Gnome
> > inflicted and can check?).
> > 
> > Why do we no longer merge? Is it too expensive?  If so, perhaps we
> 
> Linus took itout because it was quite complex and nobody seemed to have
> cases that triggered it or made it useful

What ??

It was put back in because RH GCC-2.96 triggers this too.  There was a thread
about this some months ago.

Did it get re-removed ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
