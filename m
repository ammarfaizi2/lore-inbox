Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318947AbSHMGi0>; Tue, 13 Aug 2002 02:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318949AbSHMGi0>; Tue, 13 Aug 2002 02:38:26 -0400
Received: from mail.zmailer.org ([62.240.94.4]:8430 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S318947AbSHMGiZ>;
	Tue, 13 Aug 2002 02:38:25 -0400
Date: Tue, 13 Aug 2002 09:42:15 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RE:Re: The spam problem.
Message-ID: <20020813064215.GZ32427@mea-ext.zmailer.org>
References: <20BF5713E14D5B48AA289F72BD372D6821CB15@AUSXMPC122.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D6821CB15@AUSXMPC122.aus.amer.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  (cutting down the recipient list..)

On Mon, Aug 12, 2002 at 04:09:17PM -0500, Matt_Domsch@Dell.com wrote:
> > directly on the list as members, but also the people who get LKML as
> > digest via Dell, as news, or via a mail exploder.
> 
> The digests on lists.us.dell.com are run through SpamAssassin upon receipt
> from vger.  It's caught an amazingly small number of spams (2 this month) -
> thanks to Matti and DaveM's efforts.

  Quite so.  We don't aim for 100% blocking, we can tolerate a few
  leaking thru each month.  A few each day would be too much.

  I have been monitoring what our filters do catch;  sometimes
  there are things I prefer not to be captured, which means we
  have to fine-tune the filters a bit..  I am also sometimes
  (rarely) sending a note to the message originators that their
  traffic is being captured.

  Lately I have been hammering problems with HOTMAIL - which
  internally uses some software telling "from mail pickup service"
  (or something like that), which appears also in a number of
  LOOPED messages.    I have now removed that loop-signature
  from being blocked, but I am worried...


> Thanks,
> Matt
> --
> Matt Domsch

/Matti Aarnio
