Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVHGJYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVHGJYD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 05:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVHGJYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 05:24:03 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:56068 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751340AbVHGJYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 05:24:03 -0400
Message-ID: <42F5D32C.3010400@rainbow-software.org>
Date: Sun, 07 Aug 2005 11:23:56 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris White <chriswhite@gentoo.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Logitech Quickcam Express USB Address Aquisition Issues
References: <20050807160222.0c4ee412@localhost>
In-Reply-To: <20050807160222.0c4ee412@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris White wrote:
  > As far as the host goes, I have the following USB hosts:
> 
> 0000:00:11.0 USB Controller: NEC Corporation USB (rev 43)
> 0000:00:11.1 USB Controller: NEC Corporation USB (rev 43)
> 0000:00:11.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
> 
> The first is my builtin Intel USB controller, the second is one belkin USB 1.0 card, and another 2.0 card.  I've tried it in all three just to verify one of my hosts wasn't broken.  Considering my printer works with it, as well as my scanner, I'm sort of thinking that's not an issue.
It looks like one add-on USB 2.0 card with NEC chip which is backward 
compatible with USB 1.0. No Intel here.

-- 
Ondrej Zary
