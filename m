Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUIANIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUIANIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUIANII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:08:08 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:57777 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266487AbUIANHh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:07:37 -0400
From: Romain Moyne <aero_climb@yahoo.fr>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Time runs exactly three times too fast
Date: Thu, 2 Sep 2004 18:31:54 +0200
User-Agent: KMail/1.7
References: <200409021453.09730.aero_climb@yahoo.fr> <200409021708.31410.aero_climb@yahoo.fr> <20040901130011.GB10829@redhat.com>
In-Reply-To: <20040901130011.GB10829@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409021831.55002.aero_climb@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mercredi 01 Septembre 2004 15:00, Dave Jones a écrit :
> On Thu, Sep 02, 2004 at 05:08:30PM +0200, Romain Moyne wrote:
>  > >Do you have files in /sys/devices/system/cpu/cpu0/cpufreq ?
>  >
>  > I don't.
>
> what about after modprobe powernow-k8 ?
> (that should also print out some messages in dmesg)

powernow-k8 is for athlon64, no ? I have just compiled in the kernel (not as a 
module) the option powernow-k7 (I have a Athlon XP-M).
So, I can't do modprobe powernow-k7...


>
>   Dave
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
