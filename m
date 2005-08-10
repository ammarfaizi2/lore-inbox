Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965252AbVHJSSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbVHJSSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbVHJSSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:18:47 -0400
Received: from mail.dvmed.net ([216.237.124.58]:929 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965240AbVHJSSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:18:47 -0400
Message-ID: <42FA4502.8000807@pobox.com>
Date: Wed, 10 Aug 2005 14:18:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
References: <42FA4355.7010004@gmail.com>
In-Reply-To: <42FA4355.7010004@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> Hello Jeff,
> 
> I would like to ask what the plans/timeplan to implement NCQ support for 
> NVidia NForce4(CK804) SATAII based chipsets? Fact is that is it possible 
> to use NCQ with NForce4 SATAII on Windows system, I wonder why it isn't 
> support by libata? Is there something in your git-tree? Or what are the 
> reasons/problems behind that libata is missing NCQ support for (CK804) 
> SATAII?

Ask NVIDIA.  They are the only company that gives me -zero- information 
on their SATA controllers.

As such, there are -zero- plans for NCQ on NVIDIA controllers at this time.

	Jeff



