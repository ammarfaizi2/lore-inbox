Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271809AbRHWLbP>; Thu, 23 Aug 2001 07:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271808AbRHWLbF>; Thu, 23 Aug 2001 07:31:05 -0400
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:14489 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S271809AbRHWLax>; Thu, 23 Aug 2001 07:30:53 -0400
Importance: Normal
Subject: Re: Is there any interest in Dynamic API
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF7D126203.EB32E22D-ON80256AB1.003EC909@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Thu, 23 Aug 2001 12:29:56 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.6 |December 14, 2000) at
 23/08/2001 12:28:11
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Thu, 23 Aug 2001 10:21:25 +0100,
"Keith Owens" <kaos@ocs.com.au> wrote:
>>Thanks, these are good areguments for not pursuing this. We'll proceed
with
>>conversion of dprobes to a device driver rather than a kernel module.
>
>I presume you meant a device driver rather than a syscall interface.
>Obviously a driver can be a module.

Yes, kernel_mod+syscall to ddev+ioclt instead of kmod+syscall



