Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271828AbTG2Qur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271833AbTG2Qur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:50:47 -0400
Received: from dm6-3.slc.aros.net ([66.219.221.3]:9892 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S271828AbTG2Qup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:50:45 -0400
Message-ID: <3F26A5E2.4070701@aros.net>
Date: Tue, 29 Jul 2003 10:50:42 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Voluspa <lista1@telia.com>, s.rivoir@gts.it
Subject: Re: Disk performance degradation
References: <20030729182138.76ff2d96.lista1@telia.com>
In-Reply-To: <20030729182138.76ff2d96.lista1@telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa wrote:

>On 2003-07-29 12:00:06 Stefano Rivoir wrote:
>
>  
>
>>Is there something I'm missing?!
>>    
>>
>
>No, you are not ;-) You can reclaim some speed by doing a "hdparm -a
>512". See thread for explanation (it's the borked value for readahead):
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=105830624016066&w=2
>
Anyone want to field why we aren't we just setting the default to 512 so 
users don't need to adjust this? I'm sure there's a good reason... I'd 
just like to know what it is ;-)

