Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314661AbSD1COZ>; Sat, 27 Apr 2002 22:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314664AbSD1COY>; Sat, 27 Apr 2002 22:14:24 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:49071 "EHLO
	pimout2-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S314661AbSD1COY>; Sat, 27 Apr 2002 22:14:24 -0400
Subject: Re: The tainted message
From: Richard Thrapp <rthrapp@sbcglobal.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <32711.1019958090@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 Apr 2002 21:14:19 -0500
Message-Id: <1019960059.8818.149.camel@wizard>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith, I apologize for my rash words.  I clicked send before I cooled
down, and I should know better.  I care a lot about my work.  I am
sorry.

On Sat, 2002-04-27 at 20:41, Keith Owens wrote:
> On 27 Apr 2002 20:27:07 -0500, 
> Richard Thrapp <rthrapp@sbcglobal.net> wrote:
> >On Sat, 2002-04-27 at 19:27, Keith Owens wrote:
> That is one of the many costs you have to bear for shipping binary only
> modules.  I am not going to make life easier for you.  In your original
> message to me you made no mention of the fact that you are shipping
> binary only modules, if I had know that in advance I would not have
> tried to help you, now you have no credibility with me.

I thought it was pretty obvious that I was shipping a non-GPL module
(not binary-only).  But that is not my only interest.  I have given time
and thought to many open source projects.  I genuinely wanted a more
informative error message.

> >At the very least, -please- change the verb tense of the message to be
> >correct.  That will at least eliminate the "module doesn't load" bug
> >reports (I hope).
> 
> The verb tense is correct.  The message is issued before the module is
> loaded and descibes what is about to occur.

>From the point of view of the user, who sees the message after the
module is loaded, it is incorrect and implies that the module wasn't
loaded.

-- Richard Thrapp


