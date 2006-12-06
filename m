Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935310AbWLFPSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935310AbWLFPSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935138AbWLFPSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:18:17 -0500
Received: from terminus.zytor.com ([192.83.249.54]:53019 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935072AbWLFPSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:18:15 -0500
Message-ID: <4576DF04.4000900@zytor.com>
Date: Wed, 06 Dec 2006 07:17:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux should define ENOTSUP
References: <20061206135134.GJ3927@implementation.labri.fr> <1165415115.3233.449.camel@laptopd505.fenrus.org> <20061206143159.GP3927@implementation.labri.fr>
In-Reply-To: <20061206143159.GP3927@implementation.labri.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> 
>> this is part of the ABI, so we can't change this in 2006...
> 
> Ok, so Linux will never be fully posix compliant.
> 

That's largely already the case, mostly because there is unfortunately 
still a fair bit of rubber-stamping Solaris going on.

	-hpa
