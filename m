Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264556AbRFMGpo>; Wed, 13 Jun 2001 02:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264557AbRFMGpd>; Wed, 13 Jun 2001 02:45:33 -0400
Received: from 20dyn120.com21.casema.net ([213.17.90.120]:55312 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S264556AbRFMGpU>;
	Wed, 13 Jun 2001 02:45:20 -0400
Date: Wed, 13 Jun 2001 08:43:52 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Craig Lyons <craigl@promise.com>, linux-kernel@vger.kernel.org
Subject: Re: [craigl@promise.com: Getting A Patch Into The Kernel] (fwd)
Message-ID: <20010613084352.A7423@home.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andre Hedrick <andre@linux-ide.org>,
	Craig Lyons <craigl@promise.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10106122307580.9287-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106122307580.9287-100000@master.linux-ide.org>; from andre@linux-ide.org on Tue, Jun 12, 2001 at 11:22:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 11:22:56PM -0700, Andre Hedrick wrote:

> I do not want or need your company's patches, period.

That's just not true and you know it. If the patches were to be written in
cooperation with you and of proper quality and license you would love them.

> I will not take or accept or approve of any dirty code that allows the a
> poorly written binary driver that can not control its ISR and it
> interferes irresponsiblily with the native ATA driver.

That's the real issue of course. Craig contacted you to find out what was
wrong and you should explain to him what the problems are, and how he could
solve them. Linus would accept patches written by Bill Gates if they were
licensed right and coded properly, so I don't see why Promise should be an
exception.

Never get angry at bad code. Only explain people why it's bad. At length if
needed.

Craig:

> instead each disk is seen individually, and the users data cannot be
> properly accessed. We have a patch that fixes this and are wondering if it
> is possible to get this patch into the kernel, and if so, how this would be
> done?

The procedure is to publish the patch publically and have people comment and
try it. They will often find that your code is not up to par or does things
in ways that do not please the kernel people. No evil is intended, it is
just that the kernel developers are a choosy bunch. But given the right
prodding they will tell you how you could change your code so that it is
acceptable. Alternatively, people here might see what needs to be done from
your patch, and do it themselves.

> I apologize if this is the incorrect e-mail to be making this request to. If
> this is not the correct address to be posting this message, any assistance
> as to where it should be directed would be greatly appreciated.

This was definitely the right email address :-) Mr Hedrick appears not to
like your work and as he is prone to do, he explained so graphically. This
happens. The main thing is to approach kernel coders from a technical
standpoint - they are not interested in commercial pressures or deadlines.
Get your technical people to talk to 'our' technical people and make sure
that they realise that it should be done 'our way' (as it is 'our code')
and things will go swimmingly.

> http:\\www.promise.com

Reversing those backslashes might aid your credibility here :-) If you ever
feel that you don't understand these strange linux people, please contact me
or some other people. It can be a weird country, especially coming from a
marketing devision. Thanks for trying!

But do understand that no amount of prodding, cajoling or legal pressure
will get any company anywhere. That's just not the way. As we say "It's the
code, stupid!". Good luck!

Regards,

bert hubert

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
