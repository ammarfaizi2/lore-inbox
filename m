Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUDHVCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUDHVCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:02:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:1664 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262413AbUDHVCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:02:01 -0400
Message-ID: <4075BDE0.6050302@tmr.com>
Date: Thu, 08 Apr 2004 17:02:24 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Does OSS sound work in 2.6 or not?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have several user machines I would like to convert to 2.6 because they 
run threaded applications and would be happier if I did. However, being 
able to play forwarded wav files is also needed. I have been assurred by 
several people in Email that it does, *without* converting the whole 
machine from OSS to ALSA, but by running the ALSA+OSS emulation.

if this really works, could someone point me to a working example? I 
have copied the Documentation/sound config for OSS, changing only the 
sound card type, and it totally doesn't work. It looks like it plays but 
it doesn't make any sound.

I know that if I convert to ALSA I have to use their mixer to turn up 
the sound and disable mute, if all the people telling me they do it with 
the OSS mixer and emulation are wrong, I'll just leave the machines on 
2.4 until I get some time to waste.

I have read the docs I can find, this is a yes/no question, will OSS 
work or not. I am not asking how to convert to ALSA, did that once, took 
more time than the benefit justifies.

-- 
   -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
 last possible moment - but no longer"  -me

