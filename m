Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264428AbRFSRSF>; Tue, 19 Jun 2001 13:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264429AbRFSRR4>; Tue, 19 Jun 2001 13:17:56 -0400
Received: from m7.limsi.fr ([192.44.78.7]:35591 "EHLO m7.limsi.fr")
	by vger.kernel.org with ESMTP id <S264428AbRFSRRn>;
	Tue, 19 Jun 2001 13:17:43 -0400
Message-ID: <3B2F8A59.8040508@limsi.fr>
Date: Tue, 19 Jun 2001 19:22:33 +0200
From: Damien TOURAINE <damien.touraine@limsi.fr>
Organization: LIMSI-CNRS
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18-RTC i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Direct access to the RTC ...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
I have a program that need to have a precision better than 1ms.

Is there any way to change the "tick" field of the "adjtimex" function 
to reduce it under 1000 (reprogramming the RTC) ?

Friendly


