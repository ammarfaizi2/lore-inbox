Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTFVI5U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 04:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTFVI5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 04:57:20 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:13290 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S264104AbTFVI5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 04:57:19 -0400
Message-ID: <3EF572B5.9000002@Synopsys.COM>
Date: Sun, 22 Jun 2003 11:11:17 +0200
From: Harald Dunkel <harri@synopsys.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Harald Dunkel <harri@synopsys.COM>
Subject: Re: 2.4.21: USB Mass Storage data integrity not assured?
References: <3EF556D0.5060900@Synopsys.COM>
In-Reply-To: <3EF556D0.5060900@Synopsys.COM>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> 
> Well, I need a mass storage whose integrity _is_ assured. Is there
> any hope that ehci and usb-storage get improved for a 2.4.x kernel?
> Any patches I could try?
> 

I found Greg's patches. Much better now.


Regards

Harri

