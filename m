Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313681AbSDPNz1>; Tue, 16 Apr 2002 09:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313682AbSDPNz0>; Tue, 16 Apr 2002 09:55:26 -0400
Received: from elin.scali.no ([62.70.89.10]:3851 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S313681AbSDPNzZ>;
	Tue, 16 Apr 2002 09:55:25 -0400
Subject: Re: Why HZ on i386 is 100 ?
From: Terje Eggestad <terje.eggestad@scali.com>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <l_girdwood@bitwise.co.uk>,
        BALBIR SINGH <balbir.singh@wipro.com>,
        William Olaf Fraczyk <olaf@navi.pl>,
        Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20020416093824.A4025@mark.mielke.cc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 15:55:21 +0200
Message-Id: <1018965321.13507.39.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-16 at 15:38, Mark Mielke wrote:
> On Tue, Apr 16, 2002 at 03:35:19PM +0200, Terje Eggestad wrote:
> > I seem to recall from theory that the 100HZ is human dependent. Any
> > higher and you would begin to notice delays from you input until
> > whatever program you're talking to responds. 
> 
> I suspect by "higher" you mean "each tick takes up more of a second".
> 
> As in, if the HZ is *less* than 100HZ, you would notice delays when
> typing, or similar.
> 

Quote right, my typo.

> 
> mark
> 
> -- 
> mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
> .  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
> |\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
> |  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada
> 
>   One ring to rule them all, one ring to find them, one ring to bring them all
>                        and in the darkness bind them...
> 
>                            http://mark.mielke.cc/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

