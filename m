Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpK5EWS4lLweWQD2VcqqJibo+eA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 08:38:52 +0000
Message-ID: <02e901c415a4$ae44c9a0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
Date: Mon, 29 Mar 2004 16:44:11 +0100
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
From: "Vojtech Pavlik" <vojtech@suse.cz>
To: <Administrator@smtp.paston.co.uk>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: New set of input patches
References: <200401030350.43437.dtor_core@ameritech.net> <200401050059.25031.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <200401050059.25031.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:44:13.0656 (UTC) FILETIME=[AF81DD80:01C415A4]

On Mon, Jan 05, 2004 at 12:59:24AM -0500, Dmitry Torokhov wrote:

> I made 3 more input patches:
> 
> - compile fix in 98busmose driver (it still had its interrupt routine
>   returning voooid instead of irqreturn_t)
> - the rest of mouse devices converted to the new way of handling kernel
>   parameters and document them in kernel-parametes.txt
> - convert tsdev module to the new way of handling kernel parameters and
>   document them in kernle-parameters.txt.
> 
> The patches can be found at the following addresses:
> http://www.geocities.com/dt_or/input/2_6_1-rc1/
> http://www.geocities.com/dt_or/input/2_6_1-rc1-mm1/
> 
> Vojtech, Andrew,
> 
> are you interested in these kind of patches and should I take a stab at
> converting joysticks diectory as well?

Yup, I am. :) Not sure if it's 2.6.[12] stuff, but it needs to be done
sooner or later.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
