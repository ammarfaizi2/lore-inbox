Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRHWKNP>; Thu, 23 Aug 2001 06:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271944AbRHWKNF>; Thu, 23 Aug 2001 06:13:05 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:62727 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271800AbRHWKM6>;
	Thu, 23 Aug 2001 06:12:58 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Richard J Moore" <richardj_moore@uk.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is there any interest in Dynamic API 
In-Reply-To: Your message of "Thu, 23 Aug 2001 10:21:25 +0100."
             <OFD58750A9.2C3F311E-ON80256AB1.00331AB2@portsmouth.uk.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Aug 2001 20:13:07 +1000
Message-ID: <23384.998561587@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001 10:21:25 +0100, 
"Richard J Moore" <richardj_moore@uk.ibm.com> wrote:
>Thanks, these are good areguments for not pursuing this. We'll proceed with
>conversion of dprobes to a device driver rather than a kernel module.

I presume you meant a device driver rather than a syscall interface.
Obviously a driver can be a module.

