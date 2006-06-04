Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932250AbWFDVA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWFDVA6 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWFDVA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:00:58 -0400
Received: from mail.hosted.servetheworld.net ([83.143.81.74]:31720 "HELO
	mail.hosted.servetheworld.net") by vger.kernel.org with SMTP
	id S932248AbWFDVA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:00:58 -0400
Message-ID: <44834A0F.3000502@osvik.no>
Date: Sun, 04 Jun 2006 23:01:03 +0200
From: Dag Arne Osvik <da@osvik.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060504)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Joachim Fritschi <jfritschi@freenet.de>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
References: <200606041516.46920.jfritschi@freenet.de> <200606042110.15060.ak@suse.de>
In-Reply-To: <200606042110.15060.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Sunday 04 June 2006 15:16, Joachim Fritschi wrote:
>> This patch adds the twofish x86_64 assembler routine.

>> +/* Defining a few register aliases for better reading */
> 
> Maybe you can read it now better, but for everybody else it is extremly 
> confusing. It would be better if you just used the original register names.

I'd agree if you said this code could benefit from further readability
improvements.  But you're arguing against one.

Too bad AMD kept the old register names when defining AMD64..

-- 
  Dag Arne
