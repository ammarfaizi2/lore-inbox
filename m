Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSFKTHG>; Tue, 11 Jun 2002 15:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317510AbSFKTHF>; Tue, 11 Jun 2002 15:07:05 -0400
Received: from pop.gmx.de ([213.165.64.20]:50385 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317508AbSFKTHE>;
	Tue, 11 Jun 2002 15:07:04 -0400
From: Felix Seeger <felix.seeger@gmx.de>
To: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Felix Seeger'" <seeger@sitewaerts.de>, linux-kernel@vger.kernel.org
Subject: Re: Problem with ACPI or framebuffer (no output while startup)
Date: Tue, 11 Jun 2002 21:03:45 +0200
User-Agent: KMail/1.4.5
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7EF6@orsmsx111.jf.intel.com>
Cc: Arndt Schoenewald <arndt.schoenewald@quelltext-ag.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206112103.45326.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Juni 2002 18:38 schrieb Grover, Andrew:
> > From: Felix Seeger [mailto:seeger@sitewaerts.de]
> >
> > > Executing device _INI methods: ............. (13 points)
> > >
> > > After that the output stops but the systems starts up, onyl
> >
> > the output...
>
> Known problem. ACPI is getting the bus wrong on PCI config space accesses
> and accidentally turning off the video, I believe.
>
> Regards -- Andy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Ok, can I configure this or do something else except fixing it ? ;)
ACPI is the only thing which shows my battery and AC status right.
Also it has other nice features and gives many infos about my hardware.
APM is something that never worked on my laptop.

thanks
have fun
Felix
