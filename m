Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271730AbRICPmg>; Mon, 3 Sep 2001 11:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271729AbRICPm0>; Mon, 3 Sep 2001 11:42:26 -0400
Received: from [216.151.155.121] ([216.151.155.121]:20230 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S271730AbRICPmR>; Mon, 3 Sep 2001 11:42:17 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mcelrath+linux@draal.physics.wisc.edu (Bob McElrath),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        linux-kernel@vger.kernel.org
Subject: Re: Editing-in-place of a large file
In-Reply-To: <E15dv7M-0001po-00@the-village.bc.nu>
From: Doug McNaught <doug@wireboard.com>
Date: 03 Sep 2001 11:42:27 -0400
In-Reply-To: Alan Cox's message of "Mon, 3 Sep 2001 15:54:28 +0100 (BST)"
Message-ID: <m34rqkqo0s.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> >     open(filename, O_DIRECT);     /* likewise */
> 
> Andrea has this working on 2.4 + patches

Is O_DIRECT slated to go into mainstream 2.4?  Or is it a 2.5 thing?
Or neither?

-Doug
-- 
Free Dmitry Sklyarov! 
http://www.freesklyarov.org/ 

We will return to our regularly scheduled signature shortly.
