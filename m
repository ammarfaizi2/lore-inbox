Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWECPYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWECPYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbWECPYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:24:33 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:9484 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S965217AbWECPYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:24:32 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.17-rc3 "Bus #03 (-#06) is hidden behind transparent bridge"
Date: Wed, 3 May 2006 16:24:40 +0100
User-Agent: KMail/1.9.1
Cc: gregkh@suse.de
References: <4458284F.9070604@shaw.ca> <200605030508.07526.s0348365@sms.ed.ac.uk> <44582E67.6020300@shaw.ca>
In-Reply-To: <44582E67.6020300@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605031624.40705.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 May 2006 05:15, Robert Hancock wrote:
> Alistair John Strachan wrote:
> > A lot of people seem to be seeing this, but Linux magically sorts it out.
> > I get it on my nForce4/Athlon64 X2 system and my NC6000 855PM/P-M
> > laptop..
> >
> > PCI: Transparent bridge - 0000:00:1e.0
> > PCI: Bus #05 (-#08) is hidden behind transparent bridge #02 (-#05) (try
> > 'pci=assign-busses')
> > Please report the result to linux-kernel to fix this permanently
> >
> > Not too dissimilar.. maybe this warning should be removed?
>
> The message advising to report to LKML was only added since 2.6.16
> though.. I assume somebody must have wanted to be notified :-)

Indeed, seems reasonable. Not sure Greg is the one that added this printk, but 
I've added him to CC.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
