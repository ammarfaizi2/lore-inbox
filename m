Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbUCCKNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbUCCKNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:13:23 -0500
Received: from [213.133.118.5] ([213.133.118.5]:25004 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S262384AbUCCKNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:13:20 -0500
Message-ID: <4045B1E6.9060406@shadowconnect.com>
Date: Wed, 03 Mar 2004 11:22:30 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Organization: Shadow Connect GmbH
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
       wtogami@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2o subsystem minor bugfixes to work with 2.6.3 kernel
References: <40446CCC.5070102@shadowconnect.com> <20040302133429.40b953b8.akpm@osdl.org> <40451415.10300@shadowconnect.com> <40452542.2090108@pobox.com>
In-Reply-To: <40452542.2090108@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jeff Garzik wrote:
> I'm happy someone is touching I2O subsystem again...
> What devices are you testing your changes with?

currently i only have tested them with a RAID array. That's the main usage 
of I2O controllers i think. But a tape drive would be important too in my 
opinion. If you have some other devices (e. g. scanners) which does or 
doesn't work it would be nice, if you could give me some feedback, so i 
could fix it (hopefully).


Best regards,



Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
