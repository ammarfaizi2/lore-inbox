Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289016AbSAUCr0>; Sun, 20 Jan 2002 21:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289015AbSAUCrQ>; Sun, 20 Jan 2002 21:47:16 -0500
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:15115 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S289013AbSAUCrK>;
	Sun, 20 Jan 2002 21:47:10 -0500
Message-ID: <3C4B814F.3080206@si.rr.com>
Date: Sun, 20 Jan 2002 21:47:43 -0500
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: remove i2c-old.c from 2.5.x tree?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
     I noticed that include/linux/i2c-old.h was removed in 2.5.1-pre3. 
Since drivers/media/video/i2c-parport.c and 
drivers/media/video/i2c-old.c includes i2c-old.h , does that mean that 
we can remove them from the 2.5.x tree?

Regards,
Frank

