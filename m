Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVGWOeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVGWOeV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 10:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVGWOeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 10:34:21 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:8433 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261317AbVGWOeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 10:34:20 -0400
Message-ID: <42E25562.4000503@telia.com>
Date: Sat, 23 Jul 2005 16:34:10 +0200
From: Simon Strandman <simon.strandman@telia.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: christos gentsis <christos_gentsis@yahoo.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel optimization
References: <42E14134.1040804@yahoo.co.uk> <20050722201416.GM3160@stusta.de> <42E160F5.20408@yahoo.co.uk>
In-Reply-To: <42E160F5.20408@yahoo.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christos gentsis skrev:

>
> so if i want to play with and see what happens i have to change it 
> manually in each make file... good i may create a kernel like that to 
> see what will happens (just for test) ;)
>
> thanks
> Chris
>
Just edit the top level Makefile and add your custom CFLAGS there. But 
you are risking the stability of your system and don't expect it to be 
faster.

-- 
Simon Strandman <simon.strandman@telia.com>

