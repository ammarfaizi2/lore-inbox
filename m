Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130765AbRAWSmL>; Tue, 23 Jan 2001 13:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbRAWSmC>; Tue, 23 Jan 2001 13:42:02 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:11825 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S130765AbRAWSlu>; Tue, 23 Jan 2001 13:41:50 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: [OT?] Coding Style
Date: 23 Jan 2001 13:41:43 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3zogi5cwo.fsf@shookay.e-steel.com>
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCCD@zcard00g.ca.nortel.com> <200101231600.LAA24562@mah21awu.cas.org> <14957.44505.115108.445550@somanetworks.com> <3A6DC807.1451EB61@nortelnetworks.com>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 980275209 5220 192.168.3.43 (23 Jan 2001 18:40:09 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 23 Jan 2001 18:40:09 GMT
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cfriesen@nortelnetworks.com ("Christopher Friesen") writes:

> Georg Nikodym wrote:
> 
> > I think that the distinction is moot and this argument a waste of
> > time.  If you are anything more than a code tourist, you should have
> > no trouble dealing with mnemonic names.  So the above can become:
> > 
> > /*
> >  * timcaefn == this is my clear and easy function name
> >  */
> > void timcaefn (void);
> > 
> > If you're at all concerned about RSI, your fingers will thank you.
> 
> This is why the autocompletion of functions and struct members in VC++ is
> awfully nice...hit the first few unique letters and it will complete the rest of
> the function for you, then hit tab and keep going.  Is there anything with that
> functionality under Linux?

Esc-/ under emacs...
-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
