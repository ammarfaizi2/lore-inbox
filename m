Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbUAMUqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUAMUqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:46:09 -0500
Received: from magic-mail.adaptec.com ([216.52.22.10]:26596 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S265615AbUAMUqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:46:01 -0500
Message-ID: <400458BB.6070205@adaptec.com>
Date: Tue, 13 Jan 2004 13:44:43 -0700
From: Scott Long <scott_long@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4) Gecko/20030817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mutex <mutex@cryptobackpack.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
References: <20040113182154.GH7303@heliosphan.in.cryptobackpack.org>
In-Reply-To: <20040113182154.GH7303@heliosphan.in.cryptobackpack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mutex wrote:
> On Mon, Jan 12, 2004 at 05:34:10PM -0700 or thereabouts, Scott Long
> wrote:
> 
>>All,
>>
>>Adaptec has been looking at the MD driver for a foundation for their
>>Open-Source software RAID stack.  This will help us provide full
>>and open support for current and future Adaptec RAID products (as
>>opposed to the limited support through closed drivers that we have
> 
> now).
> 
>>While MD is fairly functional and clean, there are a number of 
>>enhancements to it that we have been working on for a while and would
>>like to push out to the community for review and integration.  These
>>include:
>>
> 
> 
> 
> How about a endian safe superblock ?  Seriously, is that a 'bug' or a
> 'feature' ?  Or do people just not care.

The DDF metadata module will be endian-safe.

Scott

