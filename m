Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282271AbRLDHYc>; Tue, 4 Dec 2001 02:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282320AbRLDHYW>; Tue, 4 Dec 2001 02:24:22 -0500
Received: from [206.98.161.198] ([206.98.161.198]:21769 "EHLO
	bart.learningpatterns.com") by vger.kernel.org with ESMTP
	id <S282271AbRLDHYM>; Tue, 4 Dec 2001 02:24:12 -0500
Subject: Re: Thinkpad T20 2.4.16 hangs on resume after suspend.
From: Edward Muller <emuller@learningpatterns.com>
To: manjo@austin.rr.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C0C0534.2080201@austin.rr.com>
In-Reply-To: <3C0C0534.2080201@austin.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 02:22:19 -0500
Message-Id: <1007450539.2580.4.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI My T20 randomly hangs when suspending with 2.4.8. It seems to happen
more oftern when I've loaded many extra models, but that could just be
co-incidence. I haven't had time to upgrade to 2.4.16 yet....I will try
in a few days...

BTW: What do you mean by a 'wireless modem'? Do you mean a wireless NIC?

 On Mon, 2001-12-03 at 18:05, Manoj Iyer wrote:
> My thinkpad IBM Thinkpad T20 hangs on resume after a suspend. I have a 
> pcmcia wireless modem, on suspending the thinkpad, it goes into sleep 
> neatly but fails on resume. This happens only with 2.4.14 and later 
> kernels, my 2.4.6 kernel (with no pcmcia modules) has no problem in 
> resuming. Is this a known issue? is there a tmp workaround or proper 
> solution?? Any input is greatly appriciated. I find it very inconvinent 
> having to shutdown and reboot each time. I searched the archives but 
> yielded no answers.
> 
> Do I have to chose some wired option when I build the kernel in APM coz 
> I have pcmcia?? or is this a config issue/bug??
> 
> Save me from this pain.......
> 
> -- Manoj Iyer
> 
> ***********************************************************
> 	The greatest risk is in not taking one
> ***********************************************************
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

