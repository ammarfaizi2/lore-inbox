Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263961AbRFFRoR>; Wed, 6 Jun 2001 13:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263962AbRFFRn5>; Wed, 6 Jun 2001 13:43:57 -0400
Received: from [213.96.124.18] ([213.96.124.18]:33258 "HELO dardhal")
	by vger.kernel.org with SMTP id <S263961AbRFFRnw>;
	Wed, 6 Jun 2001 13:43:52 -0400
Date: Wed, 6 Jun 2001 19:44:32 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jldomingo@crosswinds.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
Message-ID: <20010606194432.A1858@dardhal.mired.net>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B74421C0.F6F7%bootc@worldnet.fr>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 06 June 2001, at 18:06:56 +0200,
Chris Boot wrote:

> Hi,
> 
> > Please, don't.
> > 
> > Use kelvins *0.1, and use them consistently everywhere. This is what
> > ACPI does, and it is probably right.
> 
> I'm sorry, by I don't feel like adding 273 to every number I get just to
> find the temperature of something.  What I would do is give configuration
>
What about keeping times with format similar to "06 June 2001, at 18:06:56
+0200" instead of using miliseconds from 01 Jan 1970 ? ;)

If there is a universally-accepted measure for temperatures, we should use
it, and let user space applications make the conversions for us.

Just my 0.02 (eurocents :)

--
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

