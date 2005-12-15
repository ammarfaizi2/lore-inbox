Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVLOSlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVLOSlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVLOSlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:41:49 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:24868 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750914AbVLOSlt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:41:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y0zWPuk92WrZ8RZKitU/F61+xPjtlkixT5XLIFapBIsxEFfM2GDHXQtAnFn66wXpdCjb404MNWUCf7mkcGx2Rml97GrSP4n2aZO1vsDag5o9LROftK1sv1jXWlpuewNey+oSJ5UrPU565WWNFF0tQtVy4ezJX3Pe2c8KN550QZw=
Message-ID: <6bffcb0e0512151041r4e9a35d2w@mail.gmail.com>
Date: Thu, 15 Dec 2005 19:41:47 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Martin Bligh <mbligh@mbligh.org>
Subject: Re: 2.6.15-rc5-mm3 (new build failure)
Cc: Benoit Boissinot <bboissin@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <43A1B729.5040009@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43A1A95D.10800@mbligh.org>
	 <40f323d00512151009h5eece648w80882f0cda078507@mail.gmail.com>
	 <43A1B729.5040009@mbligh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 15/12/05, Martin Bligh <mbligh@mbligh.org> wrote:
> Pah. For any good reason? or just people being lazy?
> It's worked fine for about 5 years. Difficult to beleive it's suddenly
> unworkable.

http://marc.theaimsgroup.com/?w=2&r=1&s=introduce+simple+mutex&q=t
http://kerneltrap.org/node/5974

Regards,
Michal Piotrowski
