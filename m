Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbUL1C7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUL1C7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUL1C7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:59:05 -0500
Received: from smtp-241.ig.com.br ([200.226.132.241]:23194 "EHLO
	smtp-241.ig.com.br") by vger.kernel.org with ESMTP id S262032AbUL1C6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:58:25 -0500
Message-ID: <41D0CB8E.5060006@ig.com.br>
Date: Tue, 28 Dec 2004 00:57:18 -0200
From: Eduardo Tompson Pereira <duaspila@ig.com.br>
Reply-To: duaspila@ig.com.br
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ppscsi on kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-iGspam-global: Unsure, spamicity=0.556833 - pe=5.57e-01 - pf=0.556833 - pg=0.556833
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Won't the Linux kernel include the ppscsi and all it's drivers on it?

I have this scanner (ColorPage EP) that uses the Adaptec SCSI emulation 
on the parallel port and I'm using kernel 2.4, which is doing fine with 
the patch I got from the net for this specific series.

But I'm worried because I'm thinking of going up to 2.6 and that the 
patch will be incompatible.

Why such an old driver used by so many people can't be included on the 
source, even on the 2.4 series?

Thanks,
Eduardo Tompson Pereira
duaspila@ig.com.br

PS: Please reply me personally because I'm not subscribed to the lists. 
Thanks.

