Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318063AbSGWNnN>; Tue, 23 Jul 2002 09:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318065AbSGWNnM>; Tue, 23 Jul 2002 09:43:12 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:65167 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S318063AbSGWNnM>; Tue, 23 Jul 2002 09:43:12 -0400
Subject: Re: Summit patch for 2.4.19-rc3-ac2
From: Steven Cole <elenstev@mesatop.com>
To: jamesclv@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200207222121.04788.jamesclv@us.ibm.com>
References: <200207222121.04788.jamesclv@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Jul 2002 07:42:48 -0600
Message-Id: <1027431768.7518.69.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 22:21, James Cleverdon wrote:
> Here's a patch for those who have been plagued by APIC errors starting around 
> -rc1-ac6.  I've submitted it to Alan, but since it has been affecting a 
> number of folks, I'm also posting it here for your consideration and review.
> 
> This fixes the APIC receive accept errors on the two machines we have that 
> were subject to it.  Let me know if it doesn't work for you.

Thanks.  That worked for my Intel STL2 with 2 x P-III (Coppermine).

Steven



