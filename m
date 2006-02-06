Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWBFKHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWBFKHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWBFKHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:07:15 -0500
Received: from smtp-out4.iol.cz ([194.228.2.92]:40672 "EHLO smtp-out4.iol.cz")
	by vger.kernel.org with ESMTP id S1750826AbWBFKHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:07:13 -0500
Message-ID: <43E71F75.7000605@stud.feec.vutbr.cz>
Date: Mon, 06 Feb 2006 11:05:41 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Chow <davidchow@shaolinmicro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
References: <43E71AD7.5070600@shaolinmicro.com>
In-Reply-To: <43E71AD7.5070600@shaolinmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chow wrote:
> Dear maintainers,
> 
> Is there any work in Linux undergoing to separate Linux drivers and the 
> the main kernel, and manage drivers using a package management system 
> that only manages kernel drivers and modules? If this can be done, the 
> kernel maintenance can be simple, and will end-up with a more stable 
> (less frequent changed) kernel API for drivers, also make every 
> developers of drivers happy.
> 
> Would like to see that happens .

Please read Documentation/stable_api_nonsense.txt in your copy of Linux 
source.

Michal
