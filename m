Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285329AbRLNLQJ>; Fri, 14 Dec 2001 06:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285330AbRLNLP7>; Fri, 14 Dec 2001 06:15:59 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:52964 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S285329AbRLNLPt>; Fri, 14 Dec 2001 06:15:49 -0500
Message-ID: <3C19DEAF.4080703@korseby.net>
Date: Fri, 14 Dec 2001 12:12:47 +0100
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011209
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff <piercejhsd009@earthlink.net>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord reports size vs. capabilities error....
In-Reply-To: <3C1880F4.8CE5AC8F@earthlink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff wrote:

> cdrecord: Warning: controller returns wrong size for CD capabilities
> page.
>         0,0,0     0) 'E-IDE   ' 'CD-ROM 50X      ' '50  ' Removable
> CD-ROM

Correct me if I'm wrong, but that looks like cdrecord doesn't recognize your 
cd-rom correctly. Do you have added that drive also to your lilo.conf ?

Normally it would be enough to load the modules without any specific parameters.

Could you post your dmesg-output + lilo.conf parameters if possible ?

*Kristian

