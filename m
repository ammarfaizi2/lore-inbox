Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265322AbUEUBHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265322AbUEUBHe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 21:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265318AbUEUBHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 21:07:31 -0400
Received: from pl439.nas911.n-yokohama.nttpc.ne.jp ([210.139.38.183]:38875
	"EHLO standard.erephon") by vger.kernel.org with ESMTP
	id S265325AbUEUBHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 21:07:01 -0400
Message-ID: <40AD5612.2020906@yk.rim.or.jp>
Date: Fri, 21 May 2004 10:06:26 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: James Bottomley <James.Bottomley@steeleye.com>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI updates for 2.6.6
References: <Pine.LNX.4.44.0405182140050.3207-100000@poirot.grange> <1084912724.2101.44.camel@mulgrave>
In-Reply-To: <1084912724.2101.44.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well this may be a little off topic.

But I would like to thank Kurt for supporting DC390 back in 1997 (or 
1996? I know it was before the France World Cup soccer games)
when I was contemplating of moving to Solaris or linux from OS/2.

Without his support to fix some problems (module usage, etc.),
I would not have moved to linux at all.

The DC390 is still working in my PC box to connect HP DAT2 tape drive
and CD/PD combo while faster SCSI disks are connected on other
boards.

Thank you again, Garloff-san !

PS: This trusty AMD chip board may be still alive in many
PC boxes around the world...

James Bottomley wrote:
> On Tue, 2004-05-18 at 14:47, Guennadi Liakhovetski wrote:
> 
>>Well, Kurt, thanks for the offer. I am prepared and willing to do the work
>>on supporting the driver, but I am, perhaps, not skilled enough to be a
>>maintainer of a SCSI LDD. My knowledge of the SCSI protocol and the SCSI
>>Linux subsystem is pretty limited. On one hand, the driver is little used,
>>so, even if I badly break something it is not likely to cause major
>>problems. On the other hand, I would feel more comfortable if, at least at
>>the beginning, somebody would review my patches. Besides, it would be a
>>good opportunity for me to really learn a bit more about SCSI, SCSI Linux
>>driver, BIO,...  oh well...
> 
> 
> OK, roll up for me what you'd currently like applied to the driver;
> anything that's less than solid, I'd rather mature in the -mm tree for a
> while.
> 
> James
> 
>


-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
