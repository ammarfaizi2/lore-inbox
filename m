Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbSJJEmh>; Thu, 10 Oct 2002 00:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJJEmh>; Thu, 10 Oct 2002 00:42:37 -0400
Received: from relay1.pair.com ([209.68.1.20]:39185 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S263218AbSJJEmh>;
	Thu, 10 Oct 2002 00:42:37 -0400
X-pair-Authenticated: 68.4.182.82
Content-Type: text/plain; charset=US-ASCII
From: Shane Nay <shane@minirl.com>
To: Alexander Kellett <lypanov@kde.org>, jw schultz <jw@pegasys.ws>,
       linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Date: Wed, 9 Oct 2002 21:47:25 -0700
X-Mailer: KMail [version 1.3.2]
References: <3DA1CF36.19659.13D4209@localhost> <20021008112719.GC6537@pegasys.ws> <20021009073725.GA22778@groucho.verza.com>
In-Reply-To: <20021009073725.GA22778@groucho.verza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021010044237Z263218-27218+1146@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 October 2002 00:37, Alexander Kellett wrote:
> On Tue, Oct 08, 2002 at 04:27:19AM -0700, jw schultz wrote:
> <mid-sentence snip>
>
> > You might look into something like using the adeos
> > nano-kernel to host linux and the device controll
> > software as seperate contexts with a communications
> > interface between them.
>
> <snip>
>
> This talk of adeos reminds me of something that i'd
> "dreamed" of a while back. Whats the feasability of
> having a 70kb kernel that barely even provides support
> for user space apps and is basically just an hardware
> abstraction layer for "applications" that can be
> written as kernel modules?

eCos maybe?, vxworks, nucleus, but the first one is easiest to get 
ahold of sourcewise.  A redboot type build is nearish 70kB if memory 
serves.  (I've only played around with it once on a StrongARM chip 
for kicks)

Thanks,
Shane Nay.
