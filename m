Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282823AbRLXWYJ>; Mon, 24 Dec 2001 17:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282829AbRLXWX7>; Mon, 24 Dec 2001 17:23:59 -0500
Received: from 216.234.208.21.zianet.com ([216.234.208.21]:14781 "HELO
	l33tnet0.l33tnet.com") by vger.kernel.org with SMTP
	id <S282823AbRLXWXw> convert rfc822-to-8bit; Mon, 24 Dec 2001 17:23:52 -0500
Subject: Re: Reaiser fs
From: Ian <ian@l33tnet.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <E16Iapj-0002mC-00@s.automatix.de>
In-Reply-To: <Pine.LNX.4.33.0112241550450.13979-100000@Expansa.sns.it> 
	<E16Iapj-0002mC-00@s.automatix.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 24 Dec 2001 15:26:59 -0700
Message-Id: <1009232820.2081.1.camel@hal>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
Just thought now might be a good time to mention that I have a few
servers running ReiserFS.  They have NFS'd drives shared across, and
have been up for sometime (they're running Mandrake 7.2).  Now I know
it's Mandrake, and I have no idea what they do to the RieserFS code in
the kernel, so that might be an important note.  Just thought I'd
mention that I have had these servers running for 6+ months :) Also, as
far as hardware, both servers are dual 866 MHz pentiums, with 512 megs
DDR, one with a 15 gig hard drive and the other with a 60 gig drive. 
Hope this information helps :)

--Ian Schroeder-Anderson

On Mon, 2001-12-24 at 12:32, Juergen Sauer wrote:
> Am Montag, 24. Dezember 2001 15:53 schrieb Luigi Genoni:
> > I am using NFS to share /usr and /home with reiserFS on three dual
> > Athlon 1500XP, and they have 1 month of uptime and no problems till
> > now. I am using kernel 2.4.13+mosix. I am also using a 2.4.17 NFS
> > server with reiserFS on a k6-II 475Mhz, for slackware installation with
> > NFS, and no problem also there. It happens that I have also very high
> > IO on NFS, so I think I can say it works.
> 
> Sounds Well, Merry-X Mas.
> I'll try it on the Test-Server-Range.
> 
> mfG
> 	Jojo
> 
> 
> -- 
> Jürgen Sauer - AutomatiX GmbH, +49-4209-4699, jojo@automatix.de **
> ** Das Linux Systemhaus - Service - Support - Server - Lösungen **
> http://www.automatix.de to Mail me: remove: -not-for-spawm-     **
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


