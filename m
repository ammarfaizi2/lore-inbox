Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbRLCXpa>; Mon, 3 Dec 2001 18:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282176AbRLCXjQ>; Mon, 3 Dec 2001 18:39:16 -0500
Received: from cpe-66-1-134-68.ca.sprintbbd.net ([66.1.134.68]:45032 "HELO
	core.sitedirection.com") by vger.kernel.org with SMTP
	id <S284787AbRLCQvD>; Mon, 3 Dec 2001 11:51:03 -0500
Message-ID: <028201c17c1b$c083d130$0f00a8c0@minniemouse>
From: "Jon" <marsaro@interearth.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <EXCH01SMTP01qBQNU24000068a4@smtp.netcabo.pt>
Subject: Re: SENDMAIL Ages to start !!!!!
Date: Mon, 3 Dec 2001 08:58:37 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reverse IP lookup no doubt, RH 6.2 had a real problem with that, holding the
system for a minute or more at boot time.


Regards,

Jon
----- Original Message -----
From: "Miguel Maria Godinho de Matos" <Astinus@netcabo.pt>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, December 02, 2001 3:43 AM
Subject: Fwd: SENDMAIL Ages to start !!!!!


>
>
> ----------  Forwarded Message  ----------
>
> Subject: SENDMAIL Ages to start !!!!!
> Date: Sun, 2 Dec 2001 01:29:13 +0000
> From: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
> To: linux-kernel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> I am having some prblems with sendmail since the second time i booted
linux.
>
> I have linux for about 2 months now and i just now understood that my send
> mail deamon takes too long to start.
>
> this is the log message that appeard when i upgraded linux red hat 7.1 to
7.2
> for the first time:
>
> ( firstboot after installing )
>
> Nov 18 09:48:04 localhost sendmail[1031]: alias database /etc/aliases
rebuilt
> by root
> Nov 18 09:48:04 localhost sendmail[1031]: /etc/aliases: 42 aliases,
longest
> 10 bytes, 432 bytes total
> Nov 18 09:48:04 localhost sendmail[1043]: starting daemon (8.11.6):
> SMTP+queueing@01:00:00
> Nov 18 09:53:11 localhost sendmail[1675]: fAI9rAX01675: from=root,
size=186,
> class=0, nrcpts=1,
msgid=<200111180953.fAI9rAX01675@localhost.localdomain>,
> relay=root@localhost
> Nov 18 09:53:11 localhost sendmail[1679]: fAI9rAX01675: to=root,
ctladdr=root
> (0/0), delay=00:00:01, xdelay=00:00:00, mailer=local, pri=30186,
dsn=2.0.0,
> stat=Sent
> Nov 18 10:06:18 localhost sendmail[22560]: fAIA6H722560: from=root,
size=241,
> class=0, nrcpts=1,
msgid=<200111181006.fAIA6H722560@localhost.localdomain>,
> relay=root@localhost
> Nov 18 10:06:18 localhost sendmail[22560]: fAIA6H722560: to=root,
> ctladdr=root (0/0), delay=00:00:01, xdelay=00:00:00, mailer=loc
>
> no problems this time, send mail started smoothly and quickly!!!!!!!!
>
> Well, the first thing i did when i loged in was to configure my hostname
and
> network devices.
>
> So i changed my hostname to: AstinusGod, i added this host and it's
network
> ip to the hostname table and so on!!!
>
> since then look:
>
> send mail takes ages to start and it keeps these kinda error messages in
the
> log  files:
>
> Dec  2 00:56:04 AstinusGod sendmail[9808]: My unqualified host name
> (AstinusGod) unknown; sleeping for retry
> Dec  2 00:57:12 AstinusGod sendmail[9808]: unable to qualify my own domain
> name (AstinusGod) -- using short name
> Dec  2 00:57:12 AstinusGod sendmail[9808]: fB20vCX09808: from=root,
size=230,
> class=0, nrcpts=1, msgid=<200112020057.fB20vCX09808@AstinusGod>,
> relay=root@localhost
> Dec  2 00:57:12 AstinusGod sendmail[9808]: fB20vCX09808: to=root,
> ctladdr=root (0/0), delay=00:00:00, xdelay=00:00:00, mailer=local,
pri=30230,
> dsn=2.0.0, stat=Sent
>
> I don't know what to do.... to solve this problem....
>
> i figure that if i change my hostname to localhost again, and if i remove
the
> ip entries i entered... it may be solved.. but i don't want that, just
want
> sendmail to recognize them!!!!!
>
> plz somebody help!!
>
> regards, Astinus
>
> -------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

