Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVIGTrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVIGTrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVIGTrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:47:12 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:45627 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932067AbVIGTrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:47:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=n97SpbkUA6IJb5mdl57YersyJ8EDoxE8idza1ZAyfjmbGqHaM97hvfaA/U0R4pFnkA33ikx7AobwcKDwnfCsH6XUcVJ2vOI9+FCnXbEbakeDtehumcOthNziXJtV+J+gyFN3zvZ5nRrtjAihtj1xU8J0ZfLYPV9plGfTlVSDLEA=
Message-ID: <431F42D0.6080304@gmail.com>
Date: Wed, 07 Sep 2005 22:43:12 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rob <rob.rice@fuse.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: swsusp
References: <431E97E5.1080506@fuse.net>
In-Reply-To: <431E97E5.1080506@fuse.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rob wrote:
> I singed up to this mailing list just to ask this question
> I have built a 2.6.13 kernel for a toshiba  tecra 500cdt
> this computer uses the pci buss for the sound card
> and pcmcia bridge
> I have writen a script to unload all the pci buss modules amd go to sleep
> it works up to this point
> now how do I get the modules put back when ever I add the lines to
> rerun the " /etc/rc.d/rc.hotplug /etc/rc.d/rc.pcmcia and 
> /etc/rc.d/rcmodules "
> I get a kernel crash befor it gose to sleep
> I have been al over the net and the olny info I can find is about 
> software suspend2
> Is there some way to change the sowftware suspend2 scripts to work with the
> unpatched kernel software suspend or where can I get the path to init
> talked about in the menuconfig file
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

I am using suspend2 (www.suspend2.net) which works very 
well... Have you considered it?

Best Regards,
Alon Bar-Lev.

