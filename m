Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSBOSgJ>; Fri, 15 Feb 2002 13:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290605AbSBOSgA>; Fri, 15 Feb 2002 13:36:00 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:19210 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290593AbSBOSfn>;
	Fri, 15 Feb 2002 13:35:43 -0500
Date: Fri, 15 Feb 2002 16:35:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Dennis, Jim" <jdennis@snapserver.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: XFS + rmap?
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B153AD2@cdserv.meridian-data.com>
Message-ID: <Pine.LNX.4.33L.0202151634500.12554-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Dennis, Jim wrote:

>   Has anyone been using the XFS 2.4.x patches with Rik van Riel's rmap
>  VM patches?  Any known problems with that?

Shawn Starr has been using this combination.

The only problem he found was that XFS and -rmap make
changes to the same source code files, so he had to
merge some of the code by hand.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

