Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135926AbRDTOG3>; Fri, 20 Apr 2001 10:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135925AbRDTOGT>; Fri, 20 Apr 2001 10:06:19 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:2835 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135924AbRDTOGE> convert rfc822-to-8bit; Fri, 20 Apr 2001 10:06:04 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Francois Romieu <romieu@cogenit.fr>
Subject: Re: epic100 error
Date: Fri, 20 Apr 2001 16:05:04 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010417184552.A6727@core.devicen.de> <01042010222601.06730@antares> <20010420122507.A32759@se1.cogenit.fr>
In-Reply-To: <20010420122507.A32759@se1.cogenit.fr>
MIME-Version: 1.0
Message-Id: <01042016050400.01202@antares>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 April 2001 12:25, Francois Romieu wrote:
> What happen's if you compile 2.4.2 epic100 driver in a 2.4.3 tree (I) ?
> I would really appreciate if you could give a look at (I).

I copied epic100.c from 2.4.2 into the 2.4.4-pre4 tree and it compiles and works without 
problems. 
This gives me a workable solution :-)

Cheers,
Stefan

