Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSHJGTE>; Sat, 10 Aug 2002 02:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSHJGTE>; Sat, 10 Aug 2002 02:19:04 -0400
Received: from codepoet.org ([166.70.99.138]:64209 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S316608AbSHJGTD>;
	Sat, 10 Aug 2002 02:19:03 -0400
Date: Sat, 10 Aug 2002 00:22:51 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
Message-ID: <20020810062251.GD2551@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <aivdi8$r2i$1@cesium.transmeta.com> <200208090934.g799YVZe116824@d12relay01.de.ibm.com> <200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com> <3D541018.4050004@zytor.com> <15700.4689.876752.886309@napali.hpl.hp.com> <3D541478.40808@zytor.com> <20020809222736.GJ32427@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020809222736.GJ32427@mea-ext.zmailer.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 10, 2002 at 01:27:36AM +0300, Matti Aarnio wrote:
>   glibc folks are (to an extreme pain) supporting kernels 2.0
>   (if not from before) to current bleeding edge, and emulating
>   all fancy dancing available with new system services by doing
>   some weird gimmicks..

The glibc folks care about binary compatibility.  klibc doesn't
need to care about such things, and therefore need not care about
such baggage.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
