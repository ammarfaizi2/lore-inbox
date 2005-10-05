Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVJEMbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVJEMbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVJEMbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:31:52 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:47813 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S965143AbVJEMbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:31:52 -0400
Message-ID: <4343C73E.9000507@cs.aau.dk>
Date: Wed, 05 Oct 2005 14:29:50 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: freebox possible GPL violation
References: <20051005111329.GA31087@linux.ensimag.fr>	 <4343B779.8030200@cs.aau.dk>	 <1128511676.2920.19.camel@laptopd505.fenrus.org>	 <4343BB04.7090204@cs.aau.dk>	 <1128513584.2920.23.camel@laptopd505.fenrus.org>	 <4343C0DB.9080506@cs.aau.dk> <1128514062.2920.27.camel@laptopd505.fenrus.org>
In-Reply-To: <1128514062.2920.27.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
>   3. You may copy and distribute the Program (or a work based on it,
> under Section 2) in object code or executable form under the terms of
> Sections 1 and 2 above provided that you also do one of the following:
> 
>     a) Accompany it with the complete corresponding machine-readable
>     source code, which must be distributed under the terms of Sections
>     1 and 2 above on a medium customarily used for software interchange;
> or,
> 
>     b) Accompany it with a written offer, valid for at least three
>     years, to give any third party, for a charge no more than your
>     cost of physically performing source distribution, a complete
>     machine-readable copy of the corresponding source code, to be
>     distributed under the terms of Sections 1 and 2 above on a medium
>     customarily used for software interchange; or,
> 
>     c) Accompany it with the information you received as to the offer
>     to distribute corresponding source code.  (This alternative is
>     allowed only for noncommercial distribution and only if you
>     received the program in object code or executable form with such
>     an offer, in accord with Subsection b above.)
> 
> 
> they don't do a)
> 
> they don't do b)
> 
> c) is only for noncommerial distribution (not the case here) and only if
> they got it in a type b) before, eg it allows you to transfer a type b)
> in the non-commerical case.

First, it is very arguable to say that they are "distributing" the
software as it does not comes with the FreeBox but is automatically
downloaded at each boot through the DSLAM network (which the user is not
supposed to know about).

Second, if you take the example of the LinkSys case, there was an
indirect way of getting all these informations (their website) and
_still_ you don't have all the informations you claimed in the boxes
that LinkSys is selling but on their website.

See:
http://gnumonks.org/~laforge/weblog/2005/06/13#20050613-linksys-adsl2mue

And (LinkSys GPL Code Center):
http://www.linksys.com/servlet/Satellite?childpagename=US%2FLayout&packedargs=c%3DL_Content_C1%26cid%3D1115416836002&pagename=Linksys%2FCommon%2FVisitorWrapper

If you want to know more about the _usage_ (and in matter of justice and
laws the usage is often more important than what is written down),
I would suggest you take a look at the LinkSys case.

See:
- http://lkml.org/lkml/2003/6/7/164
- http://lwn.net/Articles/53780/

Regards
-- 
Emmanuel Fleury

My life needs a rewind/erase button.
  -- Calvin & Hobbes (Bill Waterson)
