Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVGGNJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVGGNJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVGGNHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:07:18 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:3811 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261473AbVGGNFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:05:16 -0400
References: <11206164393426@foobar.com>
            <11206164442712@foobar.com>
            <84144f0205070523332cc6d487@mail.gmail.com>
            <1120740053.4860.1494.camel@localhost>
In-Reply-To: <1120740053.4860.1494.camel@localhost>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: ncunningham@cyclades.com
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 2.1.9.8 for 2.6.12: 622-swapwriter.patch
Date: Thu, 07 Jul 2005 16:05:14 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42CD288A.00003A98@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel, 

On Wed, 2005-07-06 at 16:33, Pekka Enberg wrote:
> > You're hardcoding sector size here, no?

Nigel Cunningham writes:
> As others do.

Even so, please use a constant. 

                  Pekka
