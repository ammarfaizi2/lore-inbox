Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269411AbRHQBln>; Thu, 16 Aug 2001 21:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269412AbRHQBlf>; Thu, 16 Aug 2001 21:41:35 -0400
Received: from unthought.net ([212.97.129.24]:9354 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S269411AbRHQBlY>;
	Thu, 16 Aug 2001 21:41:24 -0400
Date: Fri, 17 Aug 2001 03:41:37 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: David Ford <david@blue-labs.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: "VM watchdog"? [was Re: VM nuisance]
Message-ID: <20010817034137.B2188@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	David Ford <david@blue-labs.org>, Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B748AA8.4010105@blue-labs.org> <20010814140011.B38@toy.ucw.cz> <20010817002420.C30521@unthought.net> <3B7C72CE.60601@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3B7C72CE.60601@blue-labs.org>; from david@blue-labs.org on Thu, Aug 16, 2001 at 09:26:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 09:26:38PM -0400, David Ford wrote:
> I think it is an excellent way to do it.  Nobody said you have to run 
> the program and nobody forces you to use a particular program with a 
> particular policy.  It puts the OOM policy in userland where -you- 
> decide when and how things happen.
> 

Sure - what I was trying to say was, that I don't think the solution
will work very well.

...
> 
> The kernel allocates memory within itself.  We will still reach OOM 
> conditions.  It can't be avoided.

Good point.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
