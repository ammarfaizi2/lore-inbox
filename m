Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbQLLLCF>; Tue, 12 Dec 2000 06:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbQLLLBz>; Tue, 12 Dec 2000 06:01:55 -0500
Received: from mail.cruzio.com ([165.227.128.37]:10705 "EHLO mail.cruzio.com")
	by vger.kernel.org with ESMTP id <S130846AbQLLLBq>;
	Tue, 12 Dec 2000 06:01:46 -0500
Message-ID: <3A35FE31.533C3066@cruzio.com>
Date: Tue, 12 Dec 2000 02:30:09 -0800
From: Bruce Korb <bkorb@cruzio.com>
Organization: Home
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Android <android@abac.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18 release notes
In-Reply-To: <E145f1E-0000a9-00@the-village.bc.nu> <00121121242201.00885@cy60022-a> <20001211233956.F3199@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
>   [AC]
> > >           ... added basic support for the Pentium IV.
> [Android]
> > How is the Pentium IV more advanced than the Pentium III, other than
> > speed?  Why would LInux care about a 1500 MHz clock or 400 MHz bus
> > speed?  Just treat the PIV as a faster PIII.
> 
> It all sounds so simple, right?  Several small things to worry about:

> - maybe they'll need to patch lm_sensors to accommodate the increased
>   temperature range since the P4 runs so hot. (: (:

Did someone go through the kernel and fix spin/wait's & spin/halt's
with new magic instructions?  I remember Intel itself was working on
it, but I do not know if it was 2.4 only or 2.2 + 2.4.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
