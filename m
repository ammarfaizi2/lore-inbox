Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbSL3LTs>; Mon, 30 Dec 2002 06:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbSL3LTs>; Mon, 30 Dec 2002 06:19:48 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:29197 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266888AbSL3LTr>; Mon, 30 Dec 2002 06:19:47 -0500
Date: Mon, 30 Dec 2002 11:28:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Felix Domke <tmbinc@elitedvb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
Message-ID: <20021230112808.A26934@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Felix Domke <tmbinc@elitedvb.net>, linux-kernel@vger.kernel.org
References: <3E0FAF70.5040006@elitedvb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E0FAF70.5040006@elitedvb.net>; from tmbinc@elitedvb.net on Mon, Dec 30, 2002 at 03:29:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 03:29:04AM +0100, Felix Domke wrote:
> Hi kernel hackers,
> 
> yes, i know http://www.purists.org/linux/#indent .
> 
> my question is just: what's the matter of NOT using tabs instead of 
> spaces? i think there must be one, otherwise everybody would use tabs.
> 
> I know the thing about "more than 3 levels of indention *suck*" (but i'm 
> not sure if i have really understand this yet in my coding style, but 
> who cares..), but i like tab characters more than spaces, simply because 
> it removes all the discussion about the best indention width. some 
> people use ~180 character-consoles, some use 80 ones.Whats the reason of 
> not giving the freedom to choose whatever he likes?
> 
> i don't want to change anything, i just like to know WHY people use 
> spaces. are they somehow unportable? (i don't think so)

spaces are a workaround for broken editors.  But Linux developers have a
"use the best tool for your job" approach so we don't care :)

As someone pointed to a paper by a mozilla hacker in this thread here's
another advice:  don't use mozilla to send non mime-encoded patches, they
even implemented their brain-dead tab expansion policy in their mailer.

*sigh*

