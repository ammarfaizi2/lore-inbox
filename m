Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264029AbSIQJ66>; Tue, 17 Sep 2002 05:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264004AbSIQJ66>; Tue, 17 Sep 2002 05:58:58 -0400
Received: from AMontpellier-205-1-13-198.abo.wanadoo.fr ([80.14.68.198]:20999
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S264034AbSIQJ65> convert rfc822-to-8bit; Tue, 17 Sep 2002 05:58:57 -0400
Subject: Re: [PATCH][2.5.35] CPUfreq documentation (4/5)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, hpa@transmeta.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cpufreq@www.linux.org.uk
In-Reply-To: <20020917113547.H25385@brodo.de>
References: <20020917113547.H25385@brodo.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 12:03:55 +0200
Message-Id: <1032257043.2894.24.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 17/09/2002 à 11:35, Dominik Brodowski a écrit :

> +P4 CPU Clock Modulation:
> +    Intel Pentium 4 Xeon processors
> +---------------------------------
> +    Note that you can only switch the speed of two logical CPUs at
> +    once - but each phyiscal CPU may have different throttling levels.
> +    Unfortunately, the cpu_khz value 
> +
> +

It seems like there is a glitch here. The sentence isn't terminated
properly.



