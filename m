Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264307AbRFGDvK>; Wed, 6 Jun 2001 23:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264309AbRFGDvA>; Wed, 6 Jun 2001 23:51:00 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:22508 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S264307AbRFGDun>; Wed, 6 Jun 2001 23:50:43 -0400
Message-ID: <3B1EFA1E.892B296@ameritech.net>
Date: Wed, 06 Jun 2001 22:50:54 -0500
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Jos=E9?= Luis Domingo =?iso-8859-1?Q?L=F3pez?= 
	<jldomingo@crosswinds.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
In-Reply-To: <20010606194432.A1858@dardhal.mired.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FLAME Protection ON....

  WARNING -- Do not read if you are humor impaired.

Euro-centric here?
 

   The US is mm/dd/yy or mm/dd/yyyy
   Many countries/religions/peoples have different base years, and
calendars...

It happens to have a US format in the current kernel... so what...
Convert it in the user processes...  

And no... I can't even buy A4 paper.

Let's see....  In one evening ...
  Get American attributes out of
     Temperature
     Time
     Date

And replace with European standards.

Next week... change all comments to
Esperanto.

A year from now everything gets converted to Chinese with a 12 year
horoscope date cycle. 

Then....   The great Hindu hack
 Followed by the Orthodox date change ...
 Others follow suit....

It reaches its zenith in the great Inca knot display that only obscure
researchers can read and is then destroyed in when the Knot Printer
tangles up the legs of every computer user on the planet.....

MEANWHILE... M$ developed a bug free product while all the linux hackers
were rewriting the comments and I/O....

FLAME Protection OFF!


José Luis Domingo López wrote:
> 
> On Wednesday, 06 June 2001, at 18:06:56 +0200,
> Chris Boot wrote:
> 
> > Hi,
> >
> > > Please, don't.
> > >
> > > Use kelvins *0.1, and use them consistently everywhere. This is what
> > > ACPI does, and it is probably right.
> >
> > I'm sorry, by I don't feel like adding 273 to every number I get just to
> > find the temperature of something.  What I would do is give configuration
> >
> What about keeping times with format similar to "06 June 2001, at 18:06:56
> +0200" instead of using miliseconds from 01 Jan 1970 ? ;)
> 
> If there is a universally-accepted measure for temperatures, we should use
> it, and let user space applications make the conversions for us.
> 
> Just my 0.02 (eurocents :)
> 
> --
> José Luis Domingo López
> Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
> 
> jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
> jdomingo AT internautas DOT   org  => Spam at your own risk
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
