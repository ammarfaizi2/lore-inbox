Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbRLDBGM>; Mon, 3 Dec 2001 20:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284530AbRLDBFZ>; Mon, 3 Dec 2001 20:05:25 -0500
Received: from sm14.texas.rr.com ([24.93.35.41]:28087 "EHLO sm14.texas.rr.com")
	by vger.kernel.org with ESMTP id <S278818AbRLDBDf>;
	Mon, 3 Dec 2001 20:03:35 -0500
Message-ID: <3C0C0534.2080201@austin.rr.com>
Date: Mon, 03 Dec 2001 17:05:24 -0600
From: Manoj Iyer <manjo@austin.rr.com>
Reply-To: manjo@austin.rr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011202
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Thinkpad T20 2.4.16 hangs on resume after suspend. 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My thinkpad IBM Thinkpad T20 hangs on resume after a suspend. I have a 
pcmcia wireless modem, on suspending the thinkpad, it goes into sleep 
neatly but fails on resume. This happens only with 2.4.14 and later 
kernels, my 2.4.6 kernel (with no pcmcia modules) has no problem in 
resuming. Is this a known issue? is there a tmp workaround or proper 
solution?? Any input is greatly appriciated. I find it very inconvinent 
having to shutdown and reboot each time. I searched the archives but 
yielded no answers.

Do I have to chose some wired option when I build the kernel in APM coz 
I have pcmcia?? or is this a config issue/bug??

Save me from this pain.......

-- Manoj Iyer

***********************************************************
	The greatest risk is in not taking one
***********************************************************


