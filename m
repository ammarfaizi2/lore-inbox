Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161355AbWHAHsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161355AbWHAHsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161354AbWHAHsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:48:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:39447 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161355AbWHAHsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:48:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KDncGyjY/E4oBDj0z9KDwvIqS1JXcowLa+vdQWpS/HiDBoRuha1EC7PYkH37dTk8t6ihDQ/afOLROwcN/WDrEQKrb3QjNeaBAcwZBQr+GAkgei2Ca5tiRQwgl9rTyBuMsEtaFwnrimgVIA/ziFlEUFMiN+a3jOub2Fz5YEF2ELs=
Message-ID: <44CF0768.3050507@gmail.com>
Date: Tue, 01 Aug 2006 09:48:33 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb related oops after resume
References: <44CE96A1.2010009@gmail.com> <20060801051446.GA23206@kroah.com>
In-Reply-To: <20060801051446.GA23206@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Aug 01, 2006 at 01:47:22AM +0159, Jiri Slaby wrote:
>> Hello,
>>
>> during resume I got this oops in 2.6.18-rc1-mm2 kernel:
> 
> Does the 2.6.18-rc3 kernel work properly for you?
> 
> How about a newer -mm release?

The problem is, I can't reproduce it easily, I don't know what was the matter, 
it oopsed only once, while I was using 2.6.18-rc1-mm2. Now, I have 
2.6.18-rc2-mm1 and no oops in the time being :(.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
