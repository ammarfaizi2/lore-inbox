Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbTKUK76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 05:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbTKUK76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 05:59:58 -0500
Received: from main.gmane.org ([80.91.224.249]:15301 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264354AbTKUK75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 05:59:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Parick Beard <patrick@p-beard.com>
Subject: Re: Smartmedia 2.6.0-test9 problem.
Date: Fri, 21 Nov 2003 10:59:32 +0000
Message-ID: <pan.2003.11.21.10.59.27.222317@p-beard.com>
References: <bpcumv$v22$1@sea.gmane.org> <20031118174828.GA26450@axis.demon.co.uk> <pan.2003.11.18.21.51.11.828965@p-beard.com> <20031120225209.GA1756@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 64mb card in the reader, yet if I plug my camera in I can mount it there.
>> The 16mb card however mounts no problem in the reader.
> 
> I forgot what kind of reader and what kind of cards you used.
> This evening I fixed some problems with sddr09.c on SmartMedia cards
> larger than 16 MB.
> 
> (patch on request, or on linux-usb)

Thanks for getting back to me on this.
My cards are Olympus branded smartmedia cards (16mb & 64mb). The reader is
a Belkin usb reader (part # F5U141xMSD.

I have made a bit of progress. I've not changed my Linux install. Instead
today I bought myself a cheap 8 in 1 usb reader made by Typhoon. This
reads both cards just fine.
As the Belkin worked fine until I installed 2.6.0-test9 I would be
interested in applying your patch to see if it gets the Belkin working
again. Could you email me it please.


--
Patrick

