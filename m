Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751891AbWHUPvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWHUPvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 11:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWHUPvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 11:51:17 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:59537 "EHLO
	ns1.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751891AbWHUPvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 11:51:16 -0400
Message-ID: <44E9DD89.4030106@wolfmountaingroup.com>
Date: Mon, 21 Aug 2006 10:21:29 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: ndiswrapper]
References: <44E9D0FB.4000806@wanadoo.fr>
In-Reply-To: <44E9D0FB.4000806@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hulin Thibaud wrote:

> Hi !
> I wanted to write at the kernel-net list, but that don't works.
> I updated my kernel and compiled it to 2.6.17, but now, ndiswrapper
> don't recognize my dongle Thomson XG-1500A.
> What can I do ?
> Thanks you very much,
> Thibaud.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Use the .19 ndiswrapper and try rebuilding. 

Jeff
