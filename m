Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280415AbRJaSzc>; Wed, 31 Oct 2001 13:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280417AbRJaSzX>; Wed, 31 Oct 2001 13:55:23 -0500
Received: from [63.231.122.81] ([63.231.122.81]:10345 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280415AbRJaSzH>;
	Wed, 31 Oct 2001 13:55:07 -0500
Date: Wed, 31 Oct 2001 11:53:57 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, Timur Tabi <ttabi@interactivesi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
Message-ID: <20011031115357.J16554@lynx.no>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Larry McVoy <lm@bitmover.com>, Timur Tabi <ttabi@interactivesi.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20011031103443.K1506@work.bitmover.com> <Pine.LNX.4.33L.0110311641310.2963-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33L.0110311641310.2963-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Oct 31, 2001 at 04:44:04PM -0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Larry McVoy wrote:
> I think another way to look at it might be: if you extend a GPLed
> program using well defined interfaces, you can probably get away with
> not GPLing your code.

I imagine the question then arises to whether even the "EXPORT_SYMBOL_GPL"
interfaces fall under the definition of a well-defined interface.  I
suppose (IANAL) that the "intent" of the author in marking this interface
as GPL-only has some impact on the discussion?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

