Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSGMTWo>; Sat, 13 Jul 2002 15:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSGMTWn>; Sat, 13 Jul 2002 15:22:43 -0400
Received: from [62.70.58.70] ([62.70.58.70]:33675 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315337AbSGMTWm> convert rfc822-to-8bit;
	Sat, 13 Jul 2002 15:22:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: HELP!!! RAID problem!
Date: Sat, 13 Jul 2002 21:25:44 +0200
User-Agent: KMail/1.4.1
References: <200207132114.41697.roy@karlsbakk.net>
In-Reply-To: <200207132114.41697.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207132125.44224.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 July 2002 21:14, you wrote:
> hi all
>
> How can I force RAID devices to get status non-failed? I have a so-called 4
> out of 15 devices failed, and it failes to start.
>
> The true devices have _not_ failed!

That is - md[0123] are just fine, and as they generally are on the same drives 
as md4, something _should_ be possible

Thanks all

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

