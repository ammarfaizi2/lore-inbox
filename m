Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUGPRal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUGPRal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUGPRal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:30:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10687 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266611AbUGPRak
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:30:40 -0400
Message-ID: <40F810B2.40600@pobox.com>
Date: Fri, 16 Jul 2004 13:30:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Markus Lidel <Markus.Lidel@shadowconnect.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <Pine.LNX.4.58.0406011228130.1794@montezuma.fsmlabs.com> <40BDC553.4060809@shadowconnect.com> <Pine.LNX.4.58.0407161328030.26950@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0407161328030.26950@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would need to see the hardware specs, but I really think some 
alternate mapping solution needs to be found.

"map the entire area" may be easy, but in this case isn't the best solution.

	Jeff



