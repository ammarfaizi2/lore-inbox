Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWHTWMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWHTWMy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWHTWMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:12:53 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:50139 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751625AbWHTWMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:12:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F1l8VExyekeprzj/RiV+gKfHRkwt+ZW+J+lGWgGCbtfLmV2/jSwpYpVVvl84BheS+Ziv82iTbIt2o+TjXSNlF6ALfUa/ubO0lL1rim0nqStboE6pcCsxCaPOFd5mCii1Hzp0r6yRSvLwc4UK61nE0h3WvKL9tFMgl+MHUFdpnSQ=
Message-ID: <6bffcb0e0608201512r12d5ece5u2de4abb914cc7728@mail.gmail.com>
Date: Mon, 21 Aug 2006 00:12:52 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "jim.cromie@gmail.com" <jim.cromie@gmail.com>
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error handling
Cc: "Andrew Morton" <akpm@osdl.org>, "Frodo Looijaard" <frodol@dds.nl>,
       "Philip Edelbrock" <phil@netroedge.com>,
       "Mark Studebaker" <mdsxyz123@yahoo.com>, lm-sensors@lm-sensors.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44E8D8F7.5090000@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44E8C9AE.3060307@gmail.com> <44E8D8F7.5090000@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/06, jim.cromie@gmail.com <jim.cromie@gmail.com> wrote:
[snip]
> If youre so inclined, there are ~38 others in need
> of similar attention ;)

I'll try to fix them.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
