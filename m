Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVHPXcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVHPXcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVHPXcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:32:35 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:25506 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750733AbVHPXcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:32:35 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: udev-067 and 2.6.12?
Date: Wed, 17 Aug 2005 00:33:05 +0100
User-Agent: KMail/1.8.90
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200508162302.00900.s0348365@sms.ed.ac.uk> <20050816221450.GA28520@kroah.com> <20050816230920.GA11750@vrfy.org>
In-Reply-To: <20050816230920.GA11750@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508170033.05898.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 August 2005 00:09, Kay Sievers wrote:
[snip]
>
> Do you provide hooks for handling /etc/hotplug.d/? We are on the way of
> getting rid of that directory and recent udev versions don't handle
> that by default anymore. If you don't know, read the udev RELEASE-NOTES.
>
> Kay

I read the document, fixed the rules, and it works again. I've sent additional 
emails to the correct list this time outlining some other problems. I suspect 
they, too, are hotplug related.

(In future I'll read the documentation available in its entirety before 
pestering people. However, the way udev works is constantly changing and the 
problem I was seeing was seemingly inconsistent with an otherwise working 
udev, which made me think the problem was more deep seated..)

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
