Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWBGCum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWBGCum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWBGCum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:50:42 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:33139 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964907AbWBGCum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:50:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:in-reply-to:message-id:references:x-archive:mime-version:content-type:sender;
        b=k70t67Xh03QYTirdSPmgTVCr+bldCPejBNj9Ia8iU9RTXCrrVkoZh8yUTXY7Y7Rx4i+CF2/2TSiq08x0F/5DmwGwnApnUbzXdaea1WRUsOHCuOymsYUaGfFrpY7CbzuZCMvHio3pOa3FjK9OMQtDINRZ9SjrysQC4GyEzc1bJzw=
Date: Tue, 7 Feb 2006 00:50:36 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: What causes "USB disconnect" ?
In-Reply-To: <200602061718.08473.joshua.kugler@uaf.edu>
Message-ID: <Pine.LNX.4.64.0602070046100.2132@dyndns.pervalidus.net>
References: <Pine.LNX.4.64.0602062122480.5326@dyndns.pervalidus.net>
 <964857280602061706n72a9ebbeo9a1930f2b0993e0b@mail.gmail.com>
 <964857280602061812m748d19bew5ef0777e24359029@mail.gmail.com>
 <200602061718.08473.joshua.kugler@uaf.edu>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Joshua Kugler wrote:

> I just saw this behavior on a USB keyboard/mouse combo the 
> other day when I touched the case and discharged static 
> electricity.  Nothing else was affected, but I saw the 
> keyboard and mouse disconnect and then immediately reconnect. 
> Possibly an intolerant chipset or poorly grounded 
> motherboard.

I think it just died. I also have an USB mouse which is working 
fine, but I rebooted under 2.6.15 to see if the gamepad would 
return to live and it didn't.

About the motherboard, it's an ECS K7VTA 5.0 which I bought 
almost 3 years ago. Poorly grounded, probably, but not worse 
than it was before.

-- 
How to contact me - http://www.pervalidus.net/contact.html
