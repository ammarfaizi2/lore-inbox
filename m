Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132465AbRDWW3w>; Mon, 23 Apr 2001 18:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132462AbRDWW3l>; Mon, 23 Apr 2001 18:29:41 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45264 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132465AbRDWW1O>;
	Mon, 23 Apr 2001 18:27:14 -0400
Message-ID: <3AE4AC43.427A9180@mandrakesoft.com>
Date: Mon, 23 Apr 2001 18:27:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org, dougg@torque.net, alan@lxorguk.ukuu.org.uk,
        jlundell@pobox.com
Subject: Re: [RFC][PATCH] adding PCI bus information to SCSI layer
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E265@ausxmrr501.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:
> I've proposed a SCSI ioctl that returns PCI bus, slot, function, primary and
> subsystem vendor and device IDs.

PCI ids can be derived from bus/slot/function.

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
