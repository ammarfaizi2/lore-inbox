Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289369AbSBNCW1>; Wed, 13 Feb 2002 21:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289367AbSBNCWR>; Wed, 13 Feb 2002 21:22:17 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:32947 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S289369AbSBNCWG>; Wed, 13 Feb 2002 21:22:06 -0500
Message-ID: <3C6B1F4D.7000804@linuxhq.com>
Date: Wed, 13 Feb 2002 21:22:05 -0500
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ALSA YMF PCI Problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ALSA YMFPCI driver doesn't seem to be functioning.

I enabled the OSS API compatibility (so that I don't have to change my 
players' config), but I hear nothing but scratchy-type sounds.

I realize this is not a high priority thing, so just consider this a 
heads up.

I'll try to test more and come up with a more specific bug report.

(o- j o h n   e   w e b e r
//\  http://www.linuxhq.com/people/weber/
v_/_ john.weber@linuxhq.com

