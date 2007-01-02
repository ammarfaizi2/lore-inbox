Return-Path: <linux-kernel-owner+w=401wt.eu-S1754859AbXABOuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbXABOuM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 09:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755291AbXABOuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 09:50:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:1801 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbXABOuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 09:50:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QOFRGrYIbgR3rLIx1dGtGjyP8btL+kYMIr2tg0FTF320uvqonnFTlziLqnR/9yxHMlnvZtMxPODzlDay+yDiR1zP6lQwMt+o4B2O15yaJYQEodqjasyCVUiqXa8E8kBrIW6x4E6TnL2Rk8VX6YSD9YkANi5e0NiQOaKgTXL1DLM=
Message-ID: <3aa654a40701020650m214876e6h96a520dd9b78dbd2@mail.gmail.com>
Date: Tue, 2 Jan 2007 06:50:09 -0800
From: "Avuton Olrich" <avuton@gmail.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Subject: Re: Device does not have a release() function
Cc: LMKL <linux-kernel@vger.kernel.org>
In-Reply-To: <20070102140432.3f076f92@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3aa654a40612301612g4702e2cs4fba5151170183b@mail.gmail.com>
	 <20070102140432.3f076f92@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/07, Vitaly Bordug <vbordug@ru.mvista.com> wrote:
> Avuton,
>
> Thanks for this report,
>
> > Please excuse me if this has already been discussed. Anything else
> > that's needed please let me know.
> >
> > kernel: Linux version 2.6.20-rc2 (sbh@rocket) (gcc version 4.1.1
> > (Gentoo 4.1.1-r3)) #6 SMP PREEMPT Thu Dec 28 21:07:58 PST 2006
> >
> > Spotted this in the dmesg:
> [...]
>
> Maybe some additional failure case is not handled, I'll have a look at it.

Just need to mention all the information in the URLs is correct,
unfortunately I got the above version info from another box by
accident, so disreguard it please.
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
