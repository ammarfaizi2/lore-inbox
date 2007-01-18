Return-Path: <linux-kernel-owner+w=401wt.eu-S1751915AbXAREKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbXAREKU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 23:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXAREKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 23:10:20 -0500
Received: from web7714.mail.in.yahoo.com ([202.86.4.52]:48726 "HELO
	web7714.mail.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751915AbXAREKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 23:10:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1Q6zMmrolZjLIF73TUyw7rXZRMuzgAbNCK14U/QI8oFlWu71tL7K5rOfu7ntjkRGO+e7kYYk86fxcfkQlfSRxusSg+o/RvQZ0tWZAk6pLGe3GINoHFByxy6XhNbgszc44ZlWABvdrkV7f4ELb4p5I26u5ykq2dHWr+oLPlZ9KLQ=  ;
Message-ID: <20070118041017.56140.qmail@web7714.mail.in.yahoo.com>
X-YMail-OSG: MLElkp4VM1nqkusx_wy5eKJAtsr.ZAPoqcy2FzACJ1gDwkzkdKzq5BlJG6wPGmtVoMqt3fTPctQfdsbKSaYDe7vUrX67SgP4ZbXtpKf7UBCnEq3v.yBdHw--
Date: Thu, 18 Jan 2007 04:10:17 +0000 (GMT)
From: Seetharam Dharmosoth <seetharam_kernel@yahoo.co.in>
Subject: Re: query related to serial console
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070117114855.GB25077@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Generally sysrq will work with serial console right?

suppose system is connected through serial port to the
other system, (ie serial console), at this time we can
fire some set of commands through the serial console.

the sequesnce is as follows  
do ctrl+]
send brk
then some commands

What is my question is con't we pass commands directly

to the console (without send brk signal) ?

This is a feature in Solris..

I am looking in Linux but, uable to find it.

can you please help me

Thanks
Seetharam







--- Erik Mouw <erik@harddisk-recovery.com> wrote:

> On Wed, Jan 17, 2007 at 11:26:54AM +0000, Seetharam
> Dharmosoth wrote:
> > Is Linux having 'non-break interface for serial
> > console' ?
> 
> No idea. Could you explain what a 'non-break
> interface for serial
> console' is?
> 
> 
> Erik
> 
> -- 
> +-- Erik Mouw -- www.harddisk-recovery.com -- +31 70
> 370 12 90 --
> | Lab address: Delftechpark 26, 2628 XH, Delft, The
> Netherlands
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/
