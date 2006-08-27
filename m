Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWH0QiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWH0QiH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWH0QiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:38:07 -0400
Received: from gw.goop.org ([64.81.55.164]:16106 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932186AbWH0QiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:38:05 -0400
Message-ID: <44F1CA68.4070203@goop.org>
Date: Sun, 27 Aug 2006 09:38:00 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 6/6] Implement "current" with the PDA.
References: <20060827084417.918992193@goop.org> <20060827084453.452516832@goop.org> <200608271801.16406.ak@suse.de>
In-Reply-To: <200608271801.16406.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> With that you could remove the code in do_IRQ now that setups up a fake thread_info
> for interrupt stacks.

Oh, OK.  I was wondering what that was for.

    J

