Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280172AbRJaLpK>; Wed, 31 Oct 2001 06:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280174AbRJaLpB>; Wed, 31 Oct 2001 06:45:01 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:59541 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S280172AbRJaLou>;
	Wed, 31 Oct 2001 06:44:50 -0500
Message-ID: <3BDFE45A.6000601@stesmi.com>
Date: Wed, 31 Oct 2001 12:45:30 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Atwood <mra@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Identify IDE device?
In-Reply-To: <m3pu74k4v5.fsf@khem.blackfedora.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is there a way, via an ioctl call, or something to identify what
> specific IDE hard disk or other IDE device is hooked up to the IDE
> controller?
> 
> I'm really hoping to be able to determine something like "/dev/hda is
> a Maxtor 96147H6".
> 
> 

hdparm -i /dev/hda

// Stefan


