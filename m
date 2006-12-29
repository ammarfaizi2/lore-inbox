Return-Path: <linux-kernel-owner+w=401wt.eu-S965138AbWL2UOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWL2UOp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWL2UOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:14:45 -0500
Received: from mout1.freenet.de ([194.97.50.132]:60883 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965138AbWL2UOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:14:44 -0500
X-Greylist: delayed 6347 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 15:14:44 EST
Message-ID: <45955E67.7060408@uni-bremen.de>
Date: Fri, 29 Dec 2006 19:28:55 +0100
From: "Dr.-Ing. Ingo D. Rullhusen" <d01c@uni-bremen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: setup apm as module version 2.4.34
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i hope that's the right address for this little problem, which arises 
with linux kernel 2.4.34.

If i compile the Advanced Power Management as module it do not work. If 
i try a depmod i get an unresolved symbols message and so it cannot be 
loaded of course.

But if the APM part is compiled into the kernel directly it works.

Simply disable the compile as module option?

Thanks
   Ingo

