Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbUKUVHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbUKUVHa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUKUVHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:07:30 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:64290 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261805AbUKUVH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:07:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=jeCAFDJ4waJUuvJwthTbhWnWR75mGyJg5xv6fHreMlzLGzWiffHGohn6bWPCxcfN72oMhaWNUYL+lECD4AIkn5b1thnreKmrDpHTo0KjAKKyh3JjdYMgDsibuwP0iexonVJJbP9RxiHmppc4437wF1RLnLdBaZYvxeIycd+KNuA=
Message-ID: <ce70c4904112113072de3176b@mail.gmail.com>
Date: Sun, 21 Nov 2004 19:07:25 -0200
From: =?ISO-8859-1?Q?C=EDcero?= <cicero.mota@gmail.com>
Reply-To: =?ISO-8859-1?Q?C=EDcero?= <cicero.mota@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: information on move_tasks returns
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I am needing to catch the results of the function  move_task in
kernel/sched.c , i observed it return int value and wanted print in
screen with printk.

i create a variable int results_move_task and capture the results of
move_task, and ordered print with printk("%d",results_move_task); but
i observed that returns many one rarely return two or more, really is
this right?


[]s
Cicero


PS:Sorry about my english.
