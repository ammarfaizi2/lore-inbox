Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266428AbUBRXIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUBRXIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:08:38 -0500
Received: from viper.first4it.co.uk ([212.69.243.52]:58543 "HELO
	viper.first4it.co.uk") by vger.kernel.org with SMTP id S266428AbUBRXIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:08:36 -0500
Message-ID: <4033F069.1050206@ihateaol.co.uk>
Date: Wed, 18 Feb 2004 23:08:25 +0000
From: Kieran <kieran@ihateaol.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marco Gulino <rockman81@tin.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3: lilo warnings
References: <200402182353.41899.rockman81@tin.it>
In-Reply-To: <200402182353.41899.rockman81@tin.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Gulino wrote:

> Hi! When i upgraded from linux kernel 2.6.2 to 2.6.3 i get these warnings when 
> i run lilo... my system is all ok, however, i'm only reporting these 
> warnings.
> My distro is GNU/Linux Slackware 9.1
> Thanks :-)
> 
> bash-2.05b# lilo
> Warning: '/proc/partitions' does not match '/dev' directory structure.
>     Name change: '/dev/ram8' -> '/tmp/dev.0'
> Warning: '/dev' directory structure is incomplete; device (1, 8) is missing.
> Warning: '/dev' directory structure is incomplete; device (1, 9) is missing.
> Warning: '/dev' directory structure is incomplete; device (1, 10) is missing.
> Warning: '/dev' directory structure is incomplete; device (1, 11) is missing.
> Warning: '/dev' directory structure is incomplete; device (1, 12) is missing.
> Warning: '/dev' directory structure is incomplete; device (1, 13) is missing.
> Warning: '/dev' directory structure is incomplete; device (1, 14) is missing.
> Warning: '/dev' directory structure is incomplete; device (1, 15) is missing.
> -

I also upgraded from 2.6.2 to 2.6.3 on Slack 9.1 today and received no 
such warnings. What's in your lilo.conf?

