Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbTDAE2h>; Mon, 31 Mar 2003 23:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbTDAE2h>; Mon, 31 Mar 2003 23:28:37 -0500
Received: from ns.conceptual.net.au ([203.190.192.15]:162 "EHLO
	conceptual.net.au") by vger.kernel.org with ESMTP
	id <S262045AbTDAE2g>; Mon, 31 Mar 2003 23:28:36 -0500
Message-ID: <3E89171A.8010506@seme.com.au>
Date: Tue, 01 Apr 2003 12:35:38 +0800
From: Brad Campbell <brad@seme.com.au>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: via-rhine problem on EPIAV-1Ghz 2.4.21-pre6
References: <3E88FA24.7040406@seme.com.au> <20030401042734.GA21273@gtf.org>
In-Reply-To: <20030401042734.GA21273@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SFilter: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Tue, Apr 01, 2003 at 10:32:04AM +0800, Brad Campbell wrote:
> 
>>G'day all,
>>I have a problem with the via-rhine on this board timing out.
> 
> 
> Try booting with "noapic"
> 
> I have sent via-rhine fixes to Marcelo, hopefully they will appear in -pre7
> 
> 	Jeff
Thanks for the prompt reply Jeff.

Tried that, and I don't have apic configured in anyway.

Is there somewhere I can grab the patches so I can apply them locally 
and test them?


-- 
Brad....
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X      AGAINST HTML MAIL
  / \

