Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280758AbRKBSE4>; Fri, 2 Nov 2001 13:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280756AbRKBSEl>; Fri, 2 Nov 2001 13:04:41 -0500
Received: from [208.232.58.25] ([208.232.58.25]:16323 "EHLO kronos.usol.com")
	by vger.kernel.org with ESMTP id <S280758AbRKBSEE>;
	Fri, 2 Nov 2001 13:04:04 -0500
Subject: Re: Via onboard audio
From: Sean Middleditch <elanthis@awesomeplay.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15zii5-00037A-00@the-village.bc.nu>
In-Reply-To: <E15zii5-00037A-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.30.16.08 (Preview Release)
Date: 02 Nov 2001 13:03:13 -0500
Message-Id: <1004724193.4883.21.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-02 at 13:06, Alan Cox wrote:
> > OK, will do that.  RedHat uses your kernel trees, right?  I'll download
> > new RPM's from rawhide if they're there (I'm in no hurry.)
> 
> Both Linus and -ac current trees support
> 
> make config
> make rpm
> 
> rpm -Ivh blah...
> 
> then edit your lilo/grub config 8)

Hmm, good point, I forgot that was added.

I suppose I could be evil and ask when make deb support will be there for my
more preferred Debian boxes... But I won't ask.  ~,^

Thanks, Alan!

Sean Etc.


