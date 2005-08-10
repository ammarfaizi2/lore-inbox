Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbVHJSwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVHJSwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbVHJSwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:52:43 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:16010 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030188AbVHJSwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:52:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=RhhQpdIvNnOhops8cLmRWc2xCSv5eyf6TmTbcYe46jGG9hcpiHL4J0ufvyWn09vNrSsBj119URQmMV3JDoAodqRUJe8pNxR2aQBqEnpE4D4U8hVzKVd4LNqL1JEdx8OLBcML4VJcB5SzDpEzIfxBF4MN2TO7bA+5nuG9Dr+oRlU=
Message-ID: <42FA4CED.6090701@gmail.com>
Date: Wed, 10 Aug 2005 20:52:29 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
References: <42FA4355.7010004@gmail.com> <42FA4502.8000807@pobox.com>
In-Reply-To: <42FA4502.8000807@pobox.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik schrieb:

> Ask NVIDIA.  They are the only company that gives me -zero- 
> information on their SATA controllers.
>
Hello again,

Jeff, did you found any informations about NForce4 SATA Controller?
I found a Product Brief/Specification and a Blockdiagramm.

Also found out that the CK804 supports TCQ/NCQ

-> snip

nForce4 Ultra and nForce4 SLi can support tagged command queuing and
native command queuing when used with SATA hard disks that support
these features

-->

> As such, there are -zero- plans for NCQ on NVIDIA controllers at this 
> time.
>
>     Jeff
>
>
>
>
If NVidia followed the SATA-IO spec than should be possible to make them 
work with NCQ, or do I think wrong of that?
Or isn't it possible?

/Michael

-- 
Michael Thonke
IT-Systemintegrator /
System- and Softwareanalyist



