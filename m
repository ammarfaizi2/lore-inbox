Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261467AbSIZT47>; Thu, 26 Sep 2002 15:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261469AbSIZT47>; Thu, 26 Sep 2002 15:56:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49850 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261467AbSIZT46>; Thu, 26 Sep 2002 15:56:58 -0400
Message-ID: <3D93678B.8EF7A420@us.ibm.com>
Date: Thu, 26 Sep 2002 13:01:15 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
References: <Pine.LNX.4.44L.0209261636340.1837-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 26 Sep 2002, Larry Kessler wrote:
> 
> > Distros could be motivated to provide translations, etc. for the kernel
> > versions that they base new releases on.
> 
> Unlikely.  It's hard enough already when somebody who doesn't
> speak the language submits a bugreport by email or through
> bugzilla.
> 
> I don't want to imagine receiving a bug report from eg. Japan
> that has a cut'n'pasted kernel error in Japanese. It's not just
> that I can't read Japanese ... I don't even have the FONT to
> display it.

Right, so the tools that take kernel events and display them in 
human-readable form must be written to always display in english,
with the option to also display in another language, thus allowing
the non-English-reading SysAdmin in Japan to easily understand the
info.
