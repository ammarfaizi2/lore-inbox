Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289125AbSANWi4>; Mon, 14 Jan 2002 17:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289119AbSANWh6>; Mon, 14 Jan 2002 17:37:58 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:18555 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S289110AbSANWhh> convert rfc822-to-8bit; Mon, 14 Jan 2002 17:37:37 -0500
Date: Mon, 14 Jan 2002 23:40:34 +0100
From: Heinz Diehl <hd@cavy.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Banai Zoltan <bazooka@enclavenet.hu>, linux-kernel@vger.kernel.org
Subject: Re: slowdown with new scheduler.
Message-ID: <20020114224034.GA7899@elfie.cavy.de>
Mail-Followup-To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
	Banai Zoltan <bazooka@enclavenet.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020114202903.8BA9176330@public.kitware.com> <20020114211010Z289070-13997+4807@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020114211010Z289070-13997+4807@vger.kernel.org>
User-Agent: Mutt/1.3.25-current-20020102i (Linux 2.4.18-pre3 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by cavy.de id g0EMea3k008051
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 14 2002, Dieter Nützel wrote:

> You _must_ compare
> 2.4.18-pre3+H7+ -aa vm-22 from 2.4.18-pre2aa2
> with
> 2.4.18-pre3+H7+ -rmap

This is not possible for me since rmap-11b does not apply cleanly to
2.4.18-pre3+H7, several hunks fail. I'm not a programmer, so I'm 
not able to make the patches fit together.

> After that you should apply preempt+locl-break or LL to both.

The same here, lock-break does not apply to 2.4.18-pre3+H7 without 
some failed hunks....

-- 
# Heinz Diehl, 68259 Mannheim, Germany
