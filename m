Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315824AbSEEFwX>; Sun, 5 May 2002 01:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315825AbSEEFwW>; Sun, 5 May 2002 01:52:22 -0400
Received: from relay1.pair.com ([209.68.1.20]:58119 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S315824AbSEEFwW>;
	Sun, 5 May 2002 01:52:22 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CD4C93D.E543B188@kegel.com>
Date: Sat, 04 May 2002 22:55:09 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yossi@ixiacom.com" <yossi@ixiacom.com>
Subject: Re: khttpd newbie problem
In-Reply-To: <3CD402D2.E3A94CA2@kegel.com> <20020505005439.GA12430@krispykreme>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> > I'm having an oops with khttpd on an embedded 2.4.17 ppc405
> > system, so I thought I'd try it out on my pc.  But I can't
> > get khttpd to serve any requests.
> 
> Any reason for not using tux? Its been tested heavily on ppc64,
> the same patches should work on ppc32.

That's an excellent suggestion.  It certainly seems that khttpd
is no longer production quality (if it ever was), and tux is.

I'm on an embedded system, so if tux is much larger, I'll
be annoyed; but the system does have 64 MB, so it's not *that*
cramped.  And working is much better than crashing.
- Dan
