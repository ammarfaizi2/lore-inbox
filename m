Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSF0RsE>; Thu, 27 Jun 2002 13:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316899AbSF0RsD>; Thu, 27 Jun 2002 13:48:03 -0400
Received: from [62.70.58.70] ([62.70.58.70]:2692 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316897AbSF0RsC> convert rfc822-to-8bit;
	Thu, 27 Jun 2002 13:48:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: Can't find watchdog timer (sc1200)
Date: Thu, 27 Jun 2002 19:49:57 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206271844520.10717-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0206271844520.10717-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206271949.57333.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 June 2002 18:45, Zwane Mwaikambo wrote:
> On Thu, 27 Jun 2002, Roy Sigurd Karlsbakk wrote:
> > I can't make linux (2.4.19-rc1) detect the watchdog timer in the sc1200.
> > Any ideas?
>
> Its only in -ac, mainly because its untested and experimental. Check
> 2.4.19-pre10-ac2

there is no code for sc1200 in the pre10-ac2 patch. it's all in the official, 
and nothing has changed to -pr1

any other suggestions?

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

