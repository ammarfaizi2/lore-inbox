Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVIPVL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVIPVL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVIPVL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:11:26 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:41357 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751288AbVIPVL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:11:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Aehurzs3X3oI9yTNEWkfzElzWGAurywu77C1fuqoBaPyILRaoEeyATavVDT94WJ+7D7rjotRZnYTxRjBqw/Fu0X0wgdYTgi/Ou3bODFABLo/mlWM+9plgNDZ/F1wJnOqYXhmwWhT3Bu2BrJnVGXHwBuVsP0nvDwLNiPkEDiYnWQ=
Message-ID: <432B34D6.6010904@gmail.com>
Date: Fri, 16 Sep 2005 17:10:46 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: R52 hdaps support?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently splurged on a new ThinkPad R52 (because it was one of the few laptops 
in the store with /all/ linux-supported hardware), but the 2.6.14-rc1 kernel I 
just compiled says "hdaps: supported laptop not found".

Looking at the source I notice there's a whitelist of models that goes up to 
R51... How badly could it break if I just went ahead and added R52? Should it be 
"NORMAL" or "INVERT"?

Keenan Pepper
