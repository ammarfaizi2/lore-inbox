Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSKRUzM>; Mon, 18 Nov 2002 15:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSKRUzM>; Mon, 18 Nov 2002 15:55:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56074 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264786AbSKRUzM>;
	Mon, 18 Nov 2002 15:55:12 -0500
Message-ID: <3DD95535.8010707@pobox.com>
Date: Mon, 18 Nov 2002 16:01:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] ALSA compiler warnings fixes
References: <1037652811.8374.138.camel@phantasy>
In-Reply-To: <1037652811.8374.138.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> Linus,
>
> Attached patch fixes numerous warnings in ALSA core of the type "unused
> variable foo" due to defined-away functions.



ALSA has an active maintainer, you should at least CC them on patches to 
their subsystem...

