Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVKED6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVKED6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 22:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVKED6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 22:58:20 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:12014 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751189AbVKED6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 22:58:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=G4JW7+JvOE0ffxveJhVSV1TMGtPAmKSni+teA5Vu4rVWCVCN+Xv8ryI2sI6uy705fUAe9ozlng44W/McaS+MgCycXu6JfbvFzVXWnzMBC/3kvnnxfEG8QSoHi+gBAsarFWPRlpxmFxu2JnJw5OkD5ANk2PbJJH8ABAlIOtHz+XU=
Message-ID: <436C2DCE.1030509@pol.net>
Date: Sat, 05 Nov 2005 11:58:06 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Calin A. Culianu" <calin@ajvar.org>
CC: ajoshi@shell.unixbox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-nvidia@lists.surfsouth.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] nvidiafb: Geforce 7800 series support added
References: <Pine.LNX.4.64.0511042031470.9781@rtlab.med.cornell.edu>
In-Reply-To: <Pine.LNX.4.64.0511042031470.9781@rtlab.med.cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calin A. Culianu wrote:
> 
> Hi, this patch replaces a patch I prevously submitted.  The previous
> patch was named:
> 
>  nvidiafb-geforce-7800-gtx-support-added.patch
> 
> Which was added to the -mm tree on Oct. 25.
> 
> Can you replace the above mentioned patch with this one, since it is
> more updated?

If Linus does not merge your patch, you can wait for 2.6.14-mm1 to
come out and diff against that.  And don't forget the signed-off line.

If nobody takes your patch, I'll pick it up.

Tony
