Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWFAPvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWFAPvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWFAPvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:51:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:6093 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030209AbWFAPvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:51:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XawxFmFSbPX2rFiIcHqfgUC/kD7S3H4xTJevRExHT3wXGaxbF6BfCelITrtHhGhI6FHTZBVw+7tZrhBIxBCnw9Vd2CBzHFbGFMG0/mk7cZzt2jb+FtE80Agf6aTj643gFOzR6jQmzESWOc2otCrUjOFvuV1kEdMdEJNRUYwPXKU=
Message-ID: <6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com>
Date: Thu, 1 Jun 2006 17:51:16 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Greg KH" <gregkh@suse.de>, "Ingo Molnar" <mingo@elte.hu>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/06/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
>

I don't know why, but first bug appears only when avahi-daemon is
started. Second look like a problem with my camera.
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_1.jpg
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_2.jpg

Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
