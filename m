Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268386AbTCFV37>; Thu, 6 Mar 2003 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268399AbTCFV37>; Thu, 6 Mar 2003 16:29:59 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:52744 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S268386AbTCFV36>;
	Thu, 6 Mar 2003 16:29:58 -0500
Message-ID: <3E67C050.10500@scssoft.com>
Date: Thu, 06 Mar 2003 22:40:32 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21pre5-ac2
References: <200303061915.h26JFhP06388@devserv.devel.redhat.com>
In-Reply-To: <200303061915.h26JFhP06388@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am now getting the following errors with both
2.4.21-pre5-ac1 and 2.4.21-pre5-ac2:

hdb: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
Partition check:
 hdb:end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
end_request: I/O error, dev 03:40 (hdb), sector 0
end_request: I/O error, dev 03:40 (hdb), sector 2
end_request: I/O error, dev 03:40 (hdb), sector 4
end_request: I/O error, dev 03:40 (hdb), sector 6
 unable to read partition table

Started to happen on two different machines and didn't
happen with pre4-ac7.

Regards,
Petr


