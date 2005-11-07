Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVKGIBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVKGIBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 03:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVKGIBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 03:01:07 -0500
Received: from mgate03.necel.com ([203.180.232.83]:31436 "EHLO
	mgate03.necel.com") by vger.kernel.org with ESMTP id S1751300AbVKGIBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 03:01:05 -0500
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core: document struct class_device properly
References: <11304810242041@kroah.com>
	<200510280154.59943.dtor_core@ameritech.net>
	<20051028190937.GA16822@kroah.com>
From: Miles Bader <miles.bader@necel.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Mon, 07 Nov 2005 17:00:35 +0900
In-Reply-To: <20051028190937.GA16822@kroah.com> (Greg KH's message of "Fri, 28 Oct 2005 12:09:37 -0700")
Message-Id: <buopspcc2fw.fsf@dhapc248.dev.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
>> What about Kay's proposal about moving (as far as userspace concerned)
>> everything into /sys/devices?
>
> That's exactly what I am now working on.  But it will take much longer
> than 2.6.15 to get there for that.  More like the next 6 months or so at
> the least...

BTW, is there a reason why "devices" is plural, as opposed to the
singular names used for other directories holding types of objects
("/sys/class" "/sys/bus" "/dev" "/lib" etc.)?

Thanks,

-Miles
-- 
`There are more things in heaven and earth, Horatio,
 Than are dreamt of in your philosophy.'
