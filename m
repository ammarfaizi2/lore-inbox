Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbRAPR7A>; Tue, 16 Jan 2001 12:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAPR6u>; Tue, 16 Jan 2001 12:58:50 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:27779 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129601AbRAPR62>; Tue, 16 Jan 2001 12:58:28 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95195@ATL_MS1> 
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95195@ATL_MS1> 
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'Bryan Henderson'" <hbryan@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Jan 2001 17:58:11 +0000
Message-ID: <12057.979667891@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Venkateshr@ami.com said:
> 	[Venkatesh Ramamurthy]  

Your name is already in the headers of the mail you sent. There's no need to
repeat it.

> The LILO boot loader and the LILO command line utility should be changed
> for this.
> Is anybody doing this? -

There are patches available for the 2.2 kernel which provide the facility 
to mount by UUID or volume label. It seems that nobody is actively 
maintaining those at the moment. If you want to update those to the current 
2.2 and 2.4 kernels, well volunteered.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
