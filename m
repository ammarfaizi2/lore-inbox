Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268378AbRGXRZW>; Tue, 24 Jul 2001 13:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268379AbRGXRZM>; Tue, 24 Jul 2001 13:25:12 -0400
Received: from m7.limsi.fr ([192.44.78.7]:40719 "EHLO m7.limsi.fr")
	by vger.kernel.org with ESMTP id <S268378AbRGXRZJ>;
	Tue, 24 Jul 2001 13:25:09 -0400
Message-ID: <3B5DB110.3080606@limsi.fr>
Date: Tue, 24 Jul 2001 19:32:00 +0200
From: Damien TOURAINE <damien.touraine@limsi.fr>
Organization: LIMSI-CNRS
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Call to the scheduler...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi !
I would like to implement a system to actively wait something but 
without eating a lot of CPU.
Thus, I would like to know if there is any way to force the scheduler of 
Linux to pre-empt the current process/thread, like the "sginap(0)" 
function within IRIX.
Moreover, I don't want to have to be root to execute such function.

Friendly
    Damien TOURAINE


