Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSCSSIE>; Tue, 19 Mar 2002 13:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287858AbSCSSHz>; Tue, 19 Mar 2002 13:07:55 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:35858 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287817AbSCSSHs>; Tue, 19 Mar 2002 13:07:48 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and
    2.2.21-pre3 (client)
Date: Tue, 19 Mar 2002 15:42:33 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
    <200203110018.BAA11921@webserver.ithnet.com>
    <15499.64058.442959.241470@charged.uio.no>
    <200203180707.g2I771Z00657@mule.m17n.org> <shs8z8qb8c5.fsf@charged.uio.no>
    <200203180933.g2I9XTg07727@mule.m17n.org>
    <15509.47571.248407.537415@charged.uio.no>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1016552553 21107 10.253.0.3 (19 Mar 2002
    15:42:33 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Tue, 19 Mar 2002 15:42:33 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:142687
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <a77m99$kjj$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15509.47571.248407.537415@charged.uio.no>,
	Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> The solution is not to keep flogging the dead horse that is unfsd. It
> is to put the effort into fixing knfsd so that it can cope with all
> those cases where people are using unfsd today.
> 
> Cheers,
>    Trond

<HINT_HINT>
well, the only reasons I still use unfsd is link_relative and re-export
</HINT_HINT>
