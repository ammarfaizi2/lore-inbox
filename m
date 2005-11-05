Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVKEShW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVKEShW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVKEShW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:37:22 -0500
Received: from mail.dvmed.net ([216.237.124.58]:48575 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932178AbVKEShV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:37:21 -0500
Message-ID: <436CFBDC.8060509@pobox.com>
Date: Sat, 05 Nov 2005 13:37:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] SCSI updates for 2.6.14
References: <1131207491.3614.5.camel@mulgrave>	 <Pine.LNX.4.64.0511050942490.3316@g5.osdl.org>	 <1131214408.3614.11.camel@mulgrave>  <436CF8FC.5070906@pobox.com> <1131215595.3614.13.camel@mulgrave>
In-Reply-To: <1131215595.3614.13.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Sat, 2005-11-05 at 13:25 -0500, Jeff Garzik wrote:
> 
>>Do you have standard permissions (chmod -R og+rX) on your repo, and, are 
>>you using rsync to push to kernel.org?
>>
>>I've attached my rsync-based push script.  git people seem to dislike 
>>rsync, but this tends to work every time, for all users.
> 
> 
> No, I push to my scsi-misc-2.6 repository and then clone that on hera
> for linus.  the scsi-misc-2.6 permissions are fine, it was the clone -l
> on hera that caused the problems.

Well, _something_ is clearly screwed up in your scsi-misc-2.6 repo on 
master.kernel.org, as its the only repo that I cannot pull from (last 
successful pull was Oct 31, before I left for Portland).

	Jeff



