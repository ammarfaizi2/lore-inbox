Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbSJIPvH>; Wed, 9 Oct 2002 11:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261798AbSJIPvG>; Wed, 9 Oct 2002 11:51:06 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:35975 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S261796AbSJIPvF> convert rfc822-to-8bit;
	Wed, 9 Oct 2002 11:51:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: softdog doesn't work on 2.4.20-pre10?
Date: Wed, 9 Oct 2002 17:58:05 +0200
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210091607.32769.roy@karlsbakk.net> <200210091727.00406.roy@karlsbakk.net> <1034178374.2066.60.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1034178374.2066.60.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210091758.05793.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 October 2002 17:46, Alan Cox wrote:
> On Wed, 2002-10-09 at 16:27, Roy Sigurd Karlsbakk wrote:
> > it doesn't tell if the softdog supports the send-'V'-before-close-file
> > command to shut it down
>
> That is a shutdown in no way out mode. In default mode when you close
> the watchdog it stops

ok. so 'no way out' really means 'one way out'?

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

