Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTE3IqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTE3IqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:46:09 -0400
Received: from catv-50622120.szolcatv.broadband.hu ([80.98.33.32]:8071 "EHLO
	catv-50622120.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S263459AbTE3IqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:46:07 -0400
Message-ID: <3ED71D6D.7080408@freemail.hu>
Date: Fri, 30 May 2003 10:59:25 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm2
References: <3ED70B9A.5050104@freemail.hu> <20030530012710.57cca756.akpm@digeo.com> <20030530084419.GA29732@lst.de>
In-Reply-To: <20030530084419.GA29732@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Fri, May 30, 2003 at 01:27:10AM -0700, Andrew Morton wrote:
>  
>
>>>The line compares a struct ppa_struct* with a struct Scsi_Host *.
>>>
>>>      
>>>
>>Christoph should be able to fix that one up.
>>    
>>
>
>There already was a patch posted on either lkml or linux-scsi.
>
>
>  
>

This one?

http://marc.theaimsgroup.com/?l=linux-kernel&m=105422080609010&w=2

Thanks. It already compiles and I will test whether it works when I get 
home.
Will report monday.

Best regards,
Zoltán


