Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272362AbRIFAJ6>; Wed, 5 Sep 2001 20:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272360AbRIFAJs>; Wed, 5 Sep 2001 20:09:48 -0400
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:5346 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272359AbRIFAJn>; Wed, 5 Sep 2001 20:09:43 -0400
Message-ID: <3B96BECF.BD6633D4@home.com>
Date: Wed, 05 Sep 2001 20:09:51 -0400
From: Willem Riede <wriede@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Floydsmith@aol.com
CC: mikpe@csd.uu.se, zaitcev@redhat.com, linux-kernel@vger.kernel.org,
        linux-tape@vger.kernel.org, floyd.smith@lmco.com
Subject: Re: Re3: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read)
In-Reply-To: <32.1a68e8e6.28c739c9@aol.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Floydsmith@aol.com wrote:
> 
> The output is:
> ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0
> 
> Is there any way I can find out what the error return value asc = 2c
> represents? For example, is there a URL to a "standard" for such values?
> 
The above error is "command sequence error" - according to the
draft SCSI-2 standard that I was once able to find on the net
(but I forget where).

Success. Willem Riede.
