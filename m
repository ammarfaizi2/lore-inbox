Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266516AbTGJWew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbTGJWew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:34:52 -0400
Received: from lns-th2-5f-81-56-227-145.adsl.proxad.net ([81.56.227.145]:3968
	"EHLO smtp.ced-2.eu.org") by vger.kernel.org with ESMTP
	id S266516AbTGJWev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:34:51 -0400
Message-ID: <3F0DED78.20507@ifrance.com>
Date: Fri, 11 Jul 2003 00:49:28 +0200
From: =?ISO-8859-1?Q?C=E9dric?= <cedriccsm2@ifrance.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20030624
X-Accept-Language: fr-fr, fr, en-us, en
MIME-Version: 1.0
To: jiho@c-zone.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hdX lost interrupt problem
References: <3F0AE4DF.80808@ifrance.com> <3F0B6930.3080009@c-zone.net> <3F0BA241.8020508@c-zone.net>
In-Reply-To: <3F0BA241.8020508@c-zone.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jiho@c-zone.net wrote:

> In this machine's BIOS Setup BIOS FEATURES SETUP screen, there's the line:
> 
>   Interrupt Mode         : PIC
> 
> The other option is APIC.  Make sure it says PIC.

I had the choice to enable or disable APIC.
I disabled it, and still get lost interrupts.

> These "lost interrupt" problems date back to UDMA-33.

I probably have _very_ old IDE cables.

-- 
Cédric BARBOIRON

