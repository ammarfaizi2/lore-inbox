Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281129AbRKPF1c>; Fri, 16 Nov 2001 00:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKPF1W>; Fri, 16 Nov 2001 00:27:22 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:40852 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S281129AbRKPF1N>;
	Fri, 16 Nov 2001 00:27:13 -0500
Date: Fri, 16 Nov 2001 00:27:12 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: =?iso-8859-1?q?Marco=20Schwarz?= <mschwarz_contron@yahoo.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: How to set speed for EEPro100 ?
In-Reply-To: <20011115114301.51726.qmail@web10307.mail.yahoo.com>
Message-ID: <Pine.LNX.4.30.0111160026060.29641-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Have you tried ifconfig?  If your driver supports overriding the media
type, then ifconfig should work.  However last I recall the eepro100
driver didn't support such a feat...

On Thu, 15 Nov 2001, [iso-8859-1] Marco Schwarz wrote:

> Hi,
>
> I am having some problems with my EEPro 100 card.
> Seems like my dual speed hub doesnt like it when some
> of the cards are 10 MB and some others are 100 ....
>
> How can I force the card to use 10 MB instead of 100MB
> or auto detect ? I am using the driver included in
> kernel 2.4.9, and I couldnt find any infos on how to
> do this ...
>
> Thanks in advance
>
> Marco Schwarz
>
>
> __________________________________________________________________
>
> Gesendet von Yahoo! Mail - http://mail.yahoo.de
> Ihre E-Mail noch individueller? - http://domains.yahoo.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

