Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRKHRKd>; Thu, 8 Nov 2001 12:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276511AbRKHRKX>; Thu, 8 Nov 2001 12:10:23 -0500
Received: from fw-akustik.rz.RWTH-Aachen.DE ([137.226.38.42]:28069 "EHLO
	verdi.akustik.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S276249AbRKHRKO>; Thu, 8 Nov 2001 12:10:14 -0500
Message-ID: <3BEABC6D.F1F4E6D9@akustik.rwth-aachen.de>
Date: Thu, 08 Nov 2001 18:10:05 +0100
From: Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>
Reply-To: Andreas.Franck@akustik.rwth-aachen.de
Organization: Institut =?iso-8859-1?Q?f=FCr?= Technische Akustik
X-Mailer: Mozilla 4.75 [de] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: de, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.[10-13]-acX slows down to crawl...
In-Reply-To: <Pine.LNX.4.40.0111070948450.25917-200000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> 
> are you useing iptables or ipchains on this box?
> 
> I see you have them compiled as modules

Yes, I am using the ipchains compatibility module for the
firewall - I saw your messages regarding performance
problems with this configuration.

Can this be the cause? Are there any workarounds?

Andreas
