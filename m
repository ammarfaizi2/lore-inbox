Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWH0KBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWH0KBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 06:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWH0KBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 06:01:12 -0400
Received: from gw.goop.org ([64.81.55.164]:3506 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932088AbWH0KBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 06:01:11 -0400
Message-ID: <44F16D60.5080504@goop.org>
Date: Sun, 27 Aug 2006 03:01:04 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 3/6] Use %gs as the PDA base-segment in the kernel.
References: <11098.1156672171@ocs10w.ocs.com.au>
In-Reply-To: <11098.1156672171@ocs10w.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Now would be a good time to get rid of those hard coded numbers and use
> asm-offsets instead.
Yeah, I was considering that.  I'll do a patch.

    J
