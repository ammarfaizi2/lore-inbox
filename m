Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbSLSFKR>; Thu, 19 Dec 2002 00:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbSLSFKR>; Thu, 19 Dec 2002 00:10:17 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:15112 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267539AbSLSFKQ>; Thu, 19 Dec 2002 00:10:16 -0500
Date: Wed, 18 Dec 2002 23:26:53 -0600
From: Courtney Grimland <cgrimland@yahoo.com>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via KT400
Message-Id: <20021218232653.45c6eac7.cgrimland@yahoo.com>
In-Reply-To: <3E010F07.3000708@tupshin.com>
References: <001301c2a6ed$d9e7c3e0$0100a8c0@pcs686>
	<3E010F07.3000708@tupshin.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Real Men Don't Use Distros - www.linuxfromscratch.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the 7VAXP.  I only had problems with AGP and sound, and using
2.4.20-ac2 absolutely everything on this board works (finally -
sound!).  AGP worked in 2.4.20-ac1 as well as 2.4.21-pre1.  I think
the the IDE issue was resolved in 2.4.20.

On Wed, 18 Dec 2002 16:12:55 -0800
Tupshin Harper <tupshin@tupshin.com> wrote:

> Matthew D. Pitts wrote:
> 
> >Has anyone on the list used a motherboard that uses the Via KT400
> >AGPset? I just purchased a Gigabyte GA-7VAX that has it.
> >
> >Matthew D. Pitts
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe
> >linux-kernel" in the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >  
> >
> I'm using exactly that motherboard with no problems. There was an
> issue with DMA not being enabled on the IDE controller, but at the
> time, using kernel 2.4.19-rc2-ac3 fixed it.  I'm not sure if this
> fix went into 2.4.20 or if you still need an ac kernel.
> 
> -Tupshin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
