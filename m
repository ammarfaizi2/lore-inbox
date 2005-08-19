Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVHSJpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVHSJpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 05:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVHSJpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 05:45:33 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:19205 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S964828AbVHSJpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 05:45:32 -0400
Message-ID: <4305AA2E.7070701@rainbow-software.org>
Date: Fri, 19 Aug 2005 11:45:18 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Zwickel <martin.zwickel@technotrend.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.5: P4 2.0GHz detected as 2.6GHz?
References: <20050819113701.26d14c5a@phoebee>
In-Reply-To: <20050819113701.26d14c5a@phoebee>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zwickel wrote:
> Did someone overclock our router or is this a misdetection?

> model name      : Intel(R) Celeron(R) CPU 2.00GHz
> cpu MHz         : 2655.765
Looks like the FSB is set to 133MHz (533) instead of 100MHz (400) - in 
BIOS or by jumpers on the board.

-- 
Ondrej Zary
