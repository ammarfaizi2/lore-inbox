Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVFGLUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVFGLUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVFGLUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:20:34 -0400
Received: from wasp.net.au ([203.190.192.17]:10446 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261827AbVFGLU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:20:28 -0400
Message-ID: <42A58307.3080906@wasp.net.au>
Date: Tue, 07 Jun 2005 15:20:39 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>	<42A47376.80203@rtr.ca> <87u0kbhqsz.fsf@stark.xeocode.com>
In-Reply-To: <87u0kbhqsz.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
> Mark Lord <liml@rtr.ca> writes:

>>Eg.  smartctl -data -a /dev/sda
> 
> 
> Uh, this is 2.6.12-rc4 with the latest libata-dev patch from Garzik's web
> site:
> 
>  bash-3.00$ smartctl -data -a /dev/sda

smartctl -d ata -a /dev/sda

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
