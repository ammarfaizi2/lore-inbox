Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129921AbQK1Vqz>; Tue, 28 Nov 2000 16:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129925AbQK1Vqp>; Tue, 28 Nov 2000 16:46:45 -0500
Received: from unthought.net ([212.97.129.24]:40595 "HELO mail.unthought.net")
        by vger.kernel.org with SMTP id <S129921AbQK1Vq1>;
        Tue, 28 Nov 2000 16:46:27 -0500
Date: Tue, 28 Nov 2000 22:16:25 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Ben Ford <bford@talontech.com>
Cc: Kevin Krieser <kkrieser@delphi.com>, linux-kernel@vger.kernel.org
Subject: Re: out of swap
Message-ID: <20001128221625.A24392@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
        Ben Ford <bford@talontech.com>, Kevin Krieser <kkrieser@delphi.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A22EC94.2A434703@mindspring.com> <000b01c058ec$6791abe0$0701a8c0@thinkpad> <20001128164721.I21902@unthought.net> <3A241EDC.7646C388@talontech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3A241EDC.7646C388@talontech.com>; from bford@talontech.com on Tue, Nov 28, 2000 at 01:08:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 01:08:44PM -0800, Ben Ford wrote:
> Jakob Østergaard wrote:
> 
> <snip>
> 
> > comments, Riel or Andrea ?).  I don't know of any good solution to this problem
> > other than just having enough swap space - after all, seriously, with today's
> > disks, who can't spare an extra few hundred megs (which would usually be more
> > than enough).
> 
> An embedded system for one . . . .

If you need to browse heavily illustrated web pages on an embedded system (one
small enough to not have a disk), then use a decent browser...

/me runs...  ;)

Usually ulimits can help and tons of swap is uncalled for - but this case where
Netscape makes X consume memory on Netscape's behalf is so rare (I guess), that
I don't think this is a problem worthy of the embedded-systems-VM-discussion.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
