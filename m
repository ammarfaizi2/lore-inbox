Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280805AbRK0PSf>; Tue, 27 Nov 2001 10:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280133AbRK0PSZ>; Tue, 27 Nov 2001 10:18:25 -0500
Received: from [67.36.120.14] ([67.36.120.14]:62610 "HELO tabris.net")
	by vger.kernel.org with SMTP id <S280095AbRK0PSL>;
	Tue, 27 Nov 2001 10:18:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Organization: Dome-S-Isle Data
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, martin@jtrix.com
Subject: Re: 'spurious 8259A interrupt: IRQ7'
Date: Tue, 27 Nov 2001 10:17:37 -0500
X-Mailer: KMail [version 1.3.1]
Cc: lkml@patrickburleson.com, linux-kernel@vger.kernel.org
In-Reply-To: <E168jk1-0001J7-00@the-village.bc.nu>
In-Reply-To: <E168jk1-0001J7-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011127151737.6743EFB80D@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 November 2001 10:01, Alan Cox wrote:
> > > Something I should have added to my post is that I have a Tulip based
> > > NIC  from Netgear.  But I believe something is definitely amiss with
> > > Athlon based  machines and Tulip cards and compiled in SMP support.
> >
> > Mine is a UP box.
>
> With IO Apic support included ? If you are using an AMD/VIA combo chipset
> board that would explain it
With it turned on, but no IOAPIC (figured I did have one. But it never 
worked.) present. AMD 751/756.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
tabris

   Due to management cuts, the light at the end of the tunnel will now be
   switched off.

                                                                 Graffiti

