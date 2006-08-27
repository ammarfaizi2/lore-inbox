Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWH0Qhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWH0Qhc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWH0Qhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:37:32 -0400
Received: from gw.goop.org ([64.81.55.164]:21174 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932177AbWH0Qhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:37:31 -0400
Message-ID: <44F1CA48.7040509@goop.org>
Date: Sun, 27 Aug 2006 09:37:28 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 4/6] Fix places where using %gs changes the usermode
 ABI.
References: <20060827084417.918992193@goop.org> <20060827084452.151407233@goop.org> <200608271759.07055.ak@suse.de>
In-Reply-To: <200608271759.07055.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Didn't the eip/esp offsets change too?

Yup.  I'll recheck.

    J
