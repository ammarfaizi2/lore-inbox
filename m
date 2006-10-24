Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWJXM4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWJXM4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWJXM4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:56:09 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:4034 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1161059AbWJXM4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:56:08 -0400
Message-ID: <453E0D62.8030502@qumranet.com>
Date: Tue, 24 Oct 2006 14:56:02 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/13] KVM: userspace interface
References: <453CC390.9080508@qumranet.com> <20061023132946.49E62250143@cleopatra.q> <20061024125144.GK4943@rhun.haifa.ibm.com>
In-Reply-To: <20061024125144.GK4943@rhun.haifa.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2006 12:56:06.0244 (UTC) FILETIME=[C4D43240:01C6F76B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Mon, Oct 23, 2006 at 01:29:46PM -0000, Avi Kivity wrote:
>
>
>   
>> +		struct {
>> +		} debug;
>>     
>
> ISTR some versions of gcc had problems with empty structs.
>   

Any versions >= 3.2, which is the minimum required nowadays?

-- 
error compiling committee.c: too many arguments to function

