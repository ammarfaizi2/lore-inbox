Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSGBLYz>; Tue, 2 Jul 2002 07:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSGBLYy>; Tue, 2 Jul 2002 07:24:54 -0400
Received: from [62.70.58.70] ([62.70.58.70]:33415 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316709AbSGBLYy> convert rfc822-to-8bit;
	Tue, 2 Jul 2002 07:24:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Subject: Re: lilo/raid?
Date: Tue, 2 Jul 2002 13:27:27 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207011758180.3104-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0207011758180.3104-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207021327.27806.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 July 2002 17:59, Zwane Mwaikambo wrote:
> On Mon, 1 Jul 2002, Roy Sigurd Karlsbakk wrote:
> > LABEL=/                 /                       ext3    defaults        1
> > 1 /dev/md2                /tmp                    ext3    defaults       
> > 1 2 /dev/md3                /var                    jfs     defaults     
> >   1 2 /dev/md4                /data                   jfs     defaults   
> >     1 2 /dev/md1                swap                    swap    defaults 
> >       0 0
>
> One small thing, you do know that you can interleave swap?

What does that mean?

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

