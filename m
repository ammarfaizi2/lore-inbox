Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUCQKbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 05:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUCQKbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 05:31:01 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:60937 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S261296AbUCQKa7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 05:30:59 -0500
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmware on linux 2.6.4
References: <yw1xu10ogy4m.fsf@kth.se> <200403171119.48026@WOLK>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 17 Mar 2004 11:30:52 +0100
In-Reply-To: <200403171119.48026@WOLK> (Marc-Christian Petersen's message of
 "Wed, 17 Mar 2004 11:19:48 +0100")
Message-ID: <yw1xu10n22ar.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> writes:

> On Wednesday 17 March 2004 00:39, Måns Rullgård wrote:
>
> Hi Mans,
>
>> I tried to build the vmware modules for kernel 2.6.4 and got this oops
>> when loading vmmon.o:
>> vmmon: no version magic, tainting kernel.
>> vmmon: module license 'unspecified' taints kernel.
>> Unable to handle kernel NULL pointer dereference at virtual address
>> Suggestions welcome.
>
> what vmware version do you use? Please make sure you've updated to latest 
> any-any update from (1.)

I installed vmware 4.5.1, and at first I got an oops from insmod
again.  Then I build the modules manually instead of letting the
configure script do it, and now it's up and running.

-- 
Måns Rullgård
mru@kth.se
