Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273691AbRI0Q42>; Thu, 27 Sep 2001 12:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273693AbRI0Q4T>; Thu, 27 Sep 2001 12:56:19 -0400
Received: from pixar.pixar.com ([138.72.10.20]:10460 "EHLO pixar.pixar.com")
	by vger.kernel.org with ESMTP id <S273688AbRI0Q4B>;
	Thu, 27 Sep 2001 12:56:01 -0400
Date: Thu, 27 Sep 2001 09:53:09 -0700
From: Kiril Vidimce <vkire@pixar.com>
To: Carl Spalletta <cspalletta@nectarsystems.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: max arguments for exec
In-Reply-To: <20010927154840.74967.qmail@web13307.mail.yahoo.com>
Message-ID: <Pine.SGI.4.21.0109270952060.37081-100000@eclipse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, Carl Spalletta wrote:
> kiril, 
> 
> I am guessing that you want to avoid a custom kernel
> in order that your programs shall be portable.
> 
> So, I am having a hard time understanding why putting
> the command line args into a file instead of on the
> command line, in a way similar to grep and many other
> programs:
>  
> "fgrep -F patternfile"
> 
> would not answer the case.
> 
> Is there any absolute need to have so many args passed
> to exec from the command line?

We are using third party software over which we have no 
control. So, it's not up to us.

KV
--
  ___________________________________________________________________
  Studio Tools                                        vkire@pixar.com
  Pixar Animation Studios                        http://www.pixar.com/

