Return-Path: <linux-kernel-owner+w=401wt.eu-S1751337AbXALNdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbXALNdp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 08:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXALNdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 08:33:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:44681 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbXALNdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 08:33:45 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=f9OXTiLcD2eXo1EvGuVg2dy8WlnfBPQDQMfF5t3024BPwt3JIYC1BPBpQETBLh3clErYPgZwfO/v78tNuy71ARS4+eTmdUu4ys3u3m1dUXMj8uOiA7FUhN+2+UOR3uBGtLAmphNt8Jn9/nFOdLI555Ba1praT1jQoSpvfquhpmI=
Message-ID: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
Date: Fri, 12 Jan 2007 14:33:42 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.20-rc4-mm1 md problem
Cc: "Ingo Molnar" <mingo@elte.hu>, "Neil Brown" <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system hangs on this
http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/bug2.jpg
http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/mm-config

Debug plan:
- revert md-* patches
- binary search

Does someone have a better idea?

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
