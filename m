Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280817AbRKGPXI>; Wed, 7 Nov 2001 10:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280816AbRKGPW7>; Wed, 7 Nov 2001 10:22:59 -0500
Received: from barn.holstein.com ([198.134.143.193]:43272 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S280817AbRKGPWt>;
	Wed, 7 Nov 2001 10:22:49 -0500
Message-Id: <3BE95189.DE6E473D@holstein.com>
Date: Wed, 07 Nov 2001 10:21:45 -0500
From: "Todd M. Roy" <troy@holstein.com>
Reply-To: troy@holstein.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: barryn@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.14 compiling fail for loop device
In-Reply-To: <20011107151204.7E53389816@pobox.com>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 11/07/2001 10:21:47 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 11/07/2001 10:21:48 AM,
	Serialize complete at 11/07/2001 10:21:48 AM
X-Priority: 3 (Normal)
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would you believe that I recompiled 2.4.14 this morning
and can't seem to reproduce it now?

-- todd --

"Barry K. Nathan" wrote:
> 
> > When I did, and used a looped an iso image, eventually my
> > computer froze up.  Using the actual cd, it did not.  So my
> > personal answer would be no.
> 
> Hmmm... my *root* filesystem (with /usr, /home, etc. all on it) on one of
> my computers is loop mounted, and I've not had such a freeze with 2.4.14
> and the two lines removed... Just another data point.
> 
> -Barry K. Nathan <barryn@pobox.com>

-- 
---------------------------------------------------------------
   .~. Todd Roy, Senior Database Administrator .~.
   /V\    Holstein Association, U.S.A. Inc.    /V\
  // \\          troy@holstein.com            // \\
 /(   )\        1-802-254-4551x4230          /(   )\
  ^^-^^                                       ^^-^^
"They that can give up essential liberty to obtain a little 
temporary safety deserve neither liberty nor safety."
		-- Benjamin Franklin, 1759
---------------------------------------------------------------
**********************************************************************
This footnote confirms that this email message has been swept by 
MIMEsweeper for the presence of computer viruses.
**********************************************************************
