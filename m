Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264033AbUKZUM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbUKZUM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbUKZUJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:09:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263046AbUKZTiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:54 -0500
Message-ID: <41A5F552.2040601@blue-labs.org>
Date: Thu, 25 Nov 2004 10:08:02 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
CC: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: 2.6.10-rc2 and x86_64; spontaneous reboots
References: <41A4D5A4.3010605@blue-labs.org> <41A4EDE2.3030309@stud.feec.vutbr.cz> <41A4F198.70607@blue-labs.org> <41A4F4CA.4030803@stud.feec.vutbr.cz>
In-Reply-To: <41A4F4CA.4030803@stud.feec.vutbr.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080402030602000200090504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080402030602000200090504
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit



Michal Schmidt wrote:

> David Ford wrote:
>
>> Oddly, yes.  Or almost yes since I haven't measured it exactly.  The 
>> typical reboot is right around five minutes of uptime.  The three 
>> times that I did watch /proc/uptime, right around the 2nd column 
>> going to 300 seconds is when it rebooted.
>
>
> Well, could you send here your .config ? Do you have some strange 
> hardware?
>
> Michal
>
> PS: Please don't top-post. And the challenge-response mail filter is 
> pretty annoying.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--------------080402030602000200090504
Content-Type: application/x-gzip;
 name="x86_64-config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="x86_64-config.gz"

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
--------------080402030602000200090504--
