Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVF2V2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVF2V2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVF2V2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:28:48 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:55385 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262678AbVF2V1o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:27:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c0WTDKvpiWzE0PijxM/NKl9fYW9v0yAW2aQXOkkmE/6bJiHitlyyfRQ2ubv5PAspCJ5Lfk8G1s6l2QDxkS/CFAelM2Dr4CeAlmd5SDT/ffVjKVPwa8/LykPRmTRg4BHsHkOJ0gUFbar4zDWF5SFROebUbM5iN0AX1Fvx4Y9eiCc=
Message-ID: <9a87484905062914275c5de0c9@mail.gmail.com>
Date: Wed, 29 Jun 2005 23:27:38 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Howard Owen <hbo@egbok.com>
Subject: Re: Newbie Roadmap?
Cc: LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <1119896432.9541.88.camel@Quirk.egbok.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1119896432.9541.88.camel@Quirk.egbok.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/05, Howard Owen <hbo@egbok.com> wrote:
> I've embarked on a project to write device drivers for an obscure and
> rare ISA card. It's a modern version of the HP 82973 HP-IL interface
> produced by Cristoph Klug. HP-IL was a bit-serial, dog-slow version of
> HP-IB (IEEE-488) that was designed to work with the HP-41C family of
> calculators, and later with the HP-71 and HP-85. The 41C calculators are
> my hobby interest. I'd like to introduce myself, and ask for pointers
> for a newbie device driver author.
> 
[...]
> 
> What I've done so far: I've picked up and started reading "Linux Device
> Drivers" both editions 2 and 3. I'm about half way through Love's "Linux
> Kernel Development" 

Good choice of books.

[...]
> I'm starting
> out running Slack 10.1, so I'll probably tackle the 2.4 driver first.
> 
Slackware runs just fine with a 2.6 kernel. I've been running 2.5.x
and 2.6.x kernels on Slack for ages and I'm currently running
2.6.13-rc1 with Slackware-current.


[...]
> If anyone has suggestions or pointers for a newbie with the above
> background, I'd greatly appreciate hearing from you.
> 
You probably already know this, but since you ask I'll point out the obvious :-)

Some good documents to read : 
 Documentation/CodingStyle
 Documentation/SubmittingDrivers
 Documentation/SubmittingPatches

And this I find to be a good website for new kernel hackers : 
 http://kernelnewbies.org/


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
