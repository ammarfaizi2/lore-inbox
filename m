Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUDASKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUDASKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:10:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52421 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263020AbUDASKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:10:38 -0500
Message-ID: <406C5B0F.4020104@pobox.com>
Date: Thu, 01 Apr 2004 13:10:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>,
       mort@wildopensource.com
Subject: Re: [PATCH] libata transport attributes
References: <1080752942.27347.43.camel@lotte.street-vision.com>	 <406B3313.3080607@pobox.com> <1080820605.30218.14.camel@lotte.street-vision.com>
In-Reply-To: <1080820605.30218.14.camel@lotte.street-vision.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Cormack wrote:
> On Wed, 2004-03-31 at 22:07, Jeff Garzik wrote:
> 
> 
>>Did you see the comments I posted WRT mort's patch?
>>
> 
> 
> oops, no I missed his patch and your comments until now.
> 
> 
>>Since libata is leaving SCSI in 2.7, I would rather not add superfluous 
>>stuff like this at all.
>>
> 
> 
> I didnt know this.
> 
> 
>>Further, you can already retrieve the information you export with _zero_ 
>>new code.
> 
> 
> How? Sorry to be dumb...

Obtain the SCSI inquiry info from userspace...

	Jeff




