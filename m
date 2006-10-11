Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWJKUKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWJKUKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbWJKUKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:10:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:7942 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161206AbWJKUKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:10:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tp+9PoElVEHfgEU2C1no6F66+OUtD+lO3stsYkeElGg7uffO28MBAym2nBwaalVC7QFV+0R4tXMrtZTfDKOB6xJu6kYvQTs81jcxu58uTPA1CxJQFw3eUWQ7zNpig2HQeW5+eHosOLA7Ao2pVKuhUpKX0X9WXOuSBwr8YJ9VRHU=
Message-ID: <6bffcb0e0610111310h1d17fdc9t8e84d22edf314aab@mail.gmail.com>
Date: Wed, 11 Oct 2006 22:10:44 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Martin J. Bligh" <mbligh@google.com>
Subject: Re: 2.6.19-rc1-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Andy Whitcroft" <apw@shadowen.org>
In-Reply-To: <452D4D17.1090705@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <452D4D17.1090705@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/06, Martin J. Bligh <mbligh@google.com> wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> >
> >
> > -
> >
>
> Oh, and hangs in LTP.

It's probably a problem with fdtable patches
http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0925.html

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
