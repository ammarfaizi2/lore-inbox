Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130141AbRBVW56>; Thu, 22 Feb 2001 17:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130964AbRBVW5u>; Thu, 22 Feb 2001 17:57:50 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57106
	"EHLO gateway.matchmail.com") by vger.kernel.org with ESMTP
	id <S130141AbRBVW5m>; Thu, 22 Feb 2001 17:57:42 -0500
Message-ID: <3A95995E.B062F4F0@matchmail.com>
Date: Thu, 22 Feb 2001 14:57:34 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Catalin BOIE <util@deuroconsult.ro>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via UDMA5 3/4/5 is not functional!
In-Reply-To: <Pine.LNX.4.20.0102221004440.22238-100000@marte.Deuroconsult.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin BOIE wrote:
> i got in syslog the message: "ide0: Speed warnings UDMA 3/4/5 is not
> functional"!
> 
> What is the problem?
> 
> Thanks in advance!
> 
Wasn't dma disabled on all VIA ide chipsets because of sporadic corruption?
