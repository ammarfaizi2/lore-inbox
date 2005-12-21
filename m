Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVLUQZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVLUQZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVLUQZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:25:50 -0500
Received: from mail.scienion.de ([141.16.81.54]:32394 "EHLO
	sci36-01.hq.scienion.de") by vger.kernel.org with ESMTP
	id S932476AbVLUQZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:25:49 -0500
Message-ID: <43A981FD.5030202@scienion.de>
Date: Wed, 21 Dec 2005 17:25:33 +0100
From: Sebastian Kloska <kloska@scienion.de>
Reply-To: kloska@scienion.de
Organization: Scienion AG
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: vfat question
References: <200512211602.jBLG2QKM003368@laptop11.inf.utfsm.cl>
In-Reply-To: <200512211602.jBLG2QKM003368@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Thanks for the reply,

 I have to admit I do not even have a clue how to get access to
 the directory table of a mounted vfat device. The whole idea
 is for manipulating the ordering of mp3-players which
 (on some devices) seems to dictate the play order.
 So if someone could point me to a good documentation
 I would appreciate it.

 Regards

 Sebastian

Horst von Brand wrote:

>Sebastian Kloska <kloska@scienion.de> wrote:
>  
>
>>Is there an "official" way of  to move FAT entries
>>around in the vfat code of the kernel ? I'd like
>>to change ordering of vfat entries.
>>    
>>
>
>Why don't you do that off-line, in a userland program? Should be easier
>(and safer).
>  
>


-- 
**********************************
Dr. Sebastian Kloska
Head of Bioinformatics
Scienion AG
Volmerstr. 7a
12489 Berlin
phone: +49-(30)-6392-1747
fax:   +49-(30)-6392-1701
http://www.scienion.de
**********************************

