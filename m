Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTETRzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbTETRzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:55:53 -0400
Received: from oak.sktc.net ([64.71.97.14]:16575 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S263574AbTETRzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:55:52 -0400
Message-ID: <3ECA6F33.70600@sktc.net>
Date: Tue, 20 May 2003 13:08:51 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Wrong clock initialization
References: <3ECA673F.7B3FB388@uni-mb.si>
In-Reply-To: <3ECA673F.7B3FB388@uni-mb.si>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic wrote:

> As almost nobody runs their clock in UTC, this means that the system
> is running on wrong time until some userspace tool corrects it.


I run my clocks in UTC - the MS approach of keeping the system clock in 
local time (and having to change it twice a year, or when I'm 
travelling, or....) is too much of a pain in the ass.


