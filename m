Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292422AbSBZRkd>; Tue, 26 Feb 2002 12:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292429AbSBZRkD>; Tue, 26 Feb 2002 12:40:03 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:9149 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S292422AbSBZRjv>;
	Tue, 26 Feb 2002 12:39:51 -0500
Message-ID: <3C7BC858.5070400@tmsusa.com>
Date: Tue, 26 Feb 2002 09:39:36 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020207
X-Accept-Language: en-us
MIME-Version: 1.0
To: Guido Volpi <lugburz@tiscalinet.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: oproblem with nvidia driver
In-Reply-To: <200202261447.g1QElLO02468@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guido Volpi wrote:

>it's all right: nvidia modules depend only by nvidia, but i don't understand 
>why a module that is perfect (or so) with 2.4.17 in 2.4.18-rc4 is no more 
>usabily.
>

I'm using 2.4.18-rc4+most of the -aa patches.
nvidia works fine for me -

There are patches available that will break
the nvidia driver without warning, but that's
the problem with a binary driver - you have
to be careful about what patches you apply,
and you will lag the bleeding edge in some
areas because of driver compatibility issues.

Joe


