Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRAWSfu>; Tue, 23 Jan 2001 13:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRAWSfa>; Tue, 23 Jan 2001 13:35:30 -0500
Received: from h57s242a129n47.user.nortelnetworks.com ([47.129.242.57]:23785
	"EHLO zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S129763AbRAWSaC>; Tue, 23 Jan 2001 13:30:02 -0500
Message-ID: <3A6DC807.1451EB61@nortelnetworks.com>
Date: Tue, 23 Jan 2001 13:05:59 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: georgn@somanetworks.com
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCCD@zcard00g.ca.nortel.com> <200101231600.LAA24562@mah21awu.cas.org> <14957.44505.115108.445550@somanetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Georg Nikodym wrote:

> I think that the distinction is moot and this argument a waste of
> time.  If you are anything more than a code tourist, you should have
> no trouble dealing with mnemonic names.  So the above can become:
> 
> /*
>  * timcaefn == this is my clear and easy function name
>  */
> void timcaefn (void);
> 
> If you're at all concerned about RSI, your fingers will thank you.

This is why the autocompletion of functions and struct members in VC++ is
awfully nice...hit the first few unique letters and it will complete the rest of
the function for you, then hit tab and keep going.  Is there anything with that
functionality under Linux?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
