Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRDFLqF>; Fri, 6 Apr 2001 07:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRDFLp4>; Fri, 6 Apr 2001 07:45:56 -0400
Received: from escape.com ([198.6.71.10]:31441 "HELO escape.com")
	by vger.kernel.org with SMTP id <S131497AbRDFLpq>;
	Fri, 6 Apr 2001 07:45:46 -0400
Date: Fri, 06 Apr 2001 11:46:55 UTC
From: "Robert A. Morris" <ramorris@dilithium.net>
Reply-To: ramorris@dilithium.net
Subject: Re: 2.2.19 + ide 2.2.19 03252001 patch problem
To: linux-kernel@vger.kernel.org
Message-ID: <TradeClient.0.9.0.Linux-2.2.18.01040604465542.1473@ryoko.unguez.net>
Organization: Massachusetts Institute of Technology
X-Mailer: TradeClient 0.9.0 [en_US] Linux 2.2.18
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-Accept-Language: en_US
Sensitivity: Public-Document
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is a problem the old via-code did "82C686A" fine but knew nothing
>about "82C686B" and the new code does not do well with "82C686A" but
good
>with "82C686B".

I'd be glad to test any patches....In the meantime, is 
there an older patch that will work + apply relatively cleanly to 
2.2.19?

>Why are we mixing drives this class?

On the same cable?  I seem to get better data rates (according 
to testing with hdparm) if the newer drives are the masters.  It only
amounts to a few tenths of a MB/sec, though, so I suppose the
old drive could be the secondary master on the cable with the 
DVD-ROM.  Would this help?

Thanks for your help!
