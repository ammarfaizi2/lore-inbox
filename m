Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312386AbSDPLWo>; Tue, 16 Apr 2002 07:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSDPLWn>; Tue, 16 Apr 2002 07:22:43 -0400
Received: from achilles.noc.ntua.gr ([147.102.222.210]:41368 "EHLO ntua.gr")
	by vger.kernel.org with ESMTP id <S312386AbSDPLWn>;
	Tue, 16 Apr 2002 07:22:43 -0400
Message-ID: <3CBC0A2E.3010402@telecom.ntua.gr>
Date: Tue, 16 Apr 2002 14:25:34 +0300
From: Yannis Mitsos <gmitsos@telecom.ntua.gr>
Organization: N.T.U.A
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020314 Netscape6/6.2.2
X-Accept-Language: el, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.x and gcc version
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a member of a small team which is trying to port Linux to 
Infineon's TriCore processor.
The gcc version that is available for the aforementioned processor is 2.8.1.
On the other hand the aforementioned processor does not embed a MMU, so 
we are using the uClinux patch with the 2.4.x kernel.

I am wondering if with the 2.8.1 version we will be able to obtain a 
reliable 2.4.x kernel. According to the /Documentation/Changes file the 
gcc 2.95.3 is required...

Between the gcc version 2.8.1 and the 2.95.3 some extra flags and 
options have been added, but are all these requisite for ALL the 
processors ???

Regards

Yannis Mitsos

