Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317642AbSGJWMe>; Wed, 10 Jul 2002 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317643AbSGJWMd>; Wed, 10 Jul 2002 18:12:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27398 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317642AbSGJWMb>; Wed, 10 Jul 2002 18:12:31 -0400
Message-ID: <3D2CB1D9.20807@zytor.com>
Date: Wed, 10 Jul 2002 15:14:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OT] /proc/cpuinfo output from some arch
References: <20020707002006.B5242@flint.arm.linux.org.uk> <200207070030.g670UbT166497@saturn.cs.uml.edu> <20020710002017.GA540@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> I thought that cpuinfo was ment to be non-chaning after boot? 
> 
> Perhaps we want /proc/cpu/0/temperature containing single int?
> 

/proc/cpu/<number>/<datapoint> would be a lot better for a whole bunch
of things.

	-hpa


