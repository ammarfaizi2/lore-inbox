Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVINKD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVINKD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVINKD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:03:57 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:60803 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S965134AbVINKD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:03:56 -0400
Message-ID: <4327F586.3030901@gmail.com>
Date: Wed, 14 Sep 2005 12:03:50 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Manu Abraham <manu@kromtek.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com>
In-Reply-To: <4327EE94.2040405@kromtek.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manu Abraham napsal(a):

> Now that i have been trying to implement the driver using the new PCI 
> API, i feel a bit lost at the different changes gone into the PCI API. 
> So if someone could give me a brief idea how a minimal PCI probe 
> routine should consist of, that would be quite helpful.

Maybe, you want to read http://lwn.net/Kernel/LDD3/, chapter 12, pages 311+.

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

