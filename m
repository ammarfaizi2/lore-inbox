Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSG3Rvq>; Tue, 30 Jul 2002 13:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSG3Rvq>; Tue, 30 Jul 2002 13:51:46 -0400
Received: from unthought.net ([212.97.129.24]:9694 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S315805AbSG3Rvl>;
	Tue, 30 Jul 2002 13:51:41 -0400
Date: Tue, 30 Jul 2002 19:55:05 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RAID problems
Message-ID: <20020730175505.GI11129@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Bill Davidsen <davidsen@tmr.com>,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20020725121109.GA25999@unthought.net> <Pine.LNX.3.96.1020730132122.4849A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.3.96.1020730132122.4849A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 01:25:37PM -0400, Bill Davidsen wrote:
> On Thu, 25 Jul 2002, Jakob Oestergaard wrote:
> 
> > Just like the last time you asked this question on linux-kernel, the
> > answer is in the Software RAID HOWTO, section 6.1, and it is still
> > available at
> > 
> > http://unthought.net/Software-RAID.HOWTO/Software-RAID.HOWTO-6.html#ss6.1
> > 
> > Nothing has changed  :)
> > 
> > If you feel that the answer there is inadequate, please let me know.
> 
> I think he did by asking for help again. You might well have pointed him
> at a newsgroup or mailing list (there was one for RAID) so he could get
> some interractive support.

linux-raid@vger.kernel.org

Roy knows this.

> 
> Why does no one seem surprised that one drive failed and the system marked
> four bad instead of using the spare in the first place? That's a more
> interesting question.

As stated in the above URL (no shit, really!), this can happen for
example if some device hangs the SCSI bus.

Did *anyone* read that section ?!?   ;)

If someone feels the explanation there could be better, please just send
the better explanation to me and it will get in.  Really, this section
is one of the few sections that I did *not* update in the HOWTO, because
I really felt that it was still both adequate (since no-one has demanded
elaboration) and correct.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
