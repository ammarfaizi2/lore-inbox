Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbUKVMTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbUKVMTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 07:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbUKVMSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 07:18:24 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:34028 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262072AbUKVMQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 07:16:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=dFVOWf2gEclDjKOxwc2IU81c8ZhDT4daq9xdE/fg41Ja/jZPS+Tdae9mBok6A9huaG2JEiHWx/wFyUmCTr12cdlEOuOgNmYvUo8BsLtua78uNv3UkkPeE2q9Uky2FUC3FQGjB/4G4lD/2CBJOVzgcXfIDo4fxKdVFkmx+KRCnXk=
Message-ID: <ce70c49041122041623155a@mail.gmail.com>
Date: Mon, 22 Nov 2004 08:16:51 -0400
From: =?ISO-8859-1?Q?C=EDcero?= <cicero.mota@gmail.com>
Reply-To: =?ISO-8859-1?Q?C=EDcero?= <cicero.mota@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Information about move_tasks return
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I am looking for the result of the function  move_task in

kernel/sched.c , I have observed that it returns an int value and as I
print it with printk.

I have created a int variable 'results_move_task' which capture the result of

move_task and I print it with printk("%d",results_move_task); I
observed that it often returns the value '1' and sometimes it returns
'2' or more. Is it really correct?

[]s

PS:Sorry about my english.
