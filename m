Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVIEGGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVIEGGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVIEGGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:06:34 -0400
Received: from telis.dkts.co.yu ([195.178.60.130]:42451 "EHLO dkts.co.yu")
	by vger.kernel.org with ESMTP id S932242AbVIEGGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:06:33 -0400
Message-ID: <431BE011.8080400@dkts.co.yu>
Date: Mon, 05 Sep 2005 08:05:05 +0200
From: Zoran Stojsavljevic <zoransto@dkts.co.yu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giampaolo Tomassoni <g.tomassoni@libero.it>
CC: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org,
       linux-atm-general@lists.sourceforge.net
Subject: Re: R: [Linux-ATM-General] [ATMSAR] Request for review - update #1
References: <NBBBIHMOBLOHKCGIMJMDCEICEKAA.g.tomassoni@libero.it>
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDCEICEKAA.g.tomassoni@libero.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giampaolo Tomassoni wrote:

>Also, I believe that adsl will carry much more services then just AAL5 for internet connection in the future. Even if the ATMSAR actually lacks of AAL1 and AAL2/3 capabilities, adding them in a single, specialized module is much easier than swimming in a usb+atm middle layer.
>  
>
Giampaolo,

Should read: ...even if the ATMSAR actually lacks of AAL1, AAL2 and AAL3/4 [where AAL3/4 is obsolete] capabilities...

Just wanted to make it more precise according to the ATM standards, this was the only intention of my "patch".

Peace to all! :o)



