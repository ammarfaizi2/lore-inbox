Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311932AbSCOEzp>; Thu, 14 Mar 2002 23:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311934AbSCOEzf>; Thu, 14 Mar 2002 23:55:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11025 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311931AbSCOEzZ>;
	Thu, 14 Mar 2002 23:55:25 -0500
Message-ID: <3C917EAC.1080401@mandrakesoft.com>
Date: Thu, 14 Mar 2002 23:55:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
In-Reply-To: <200203150238.g2F2cGe21131@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>How do those of us who've been using the
>
>http://gkernel.bitkeeper.net/marcelo-2.4
>
>for development resync against the kernel24.bkbits.net tree?
>


Through the magic of BK :)

Just do a 'bk pull' on my marcelo-2.4 tree.  Since it is based on the 
original linux-2.4 tree just like Marcelo's tree, I was able to merge 
from my 2.4 line to his 2.4 line.

    Jeff




