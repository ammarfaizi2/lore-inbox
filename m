Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbULYEU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbULYEU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 23:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbULYEU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 23:20:28 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:54984 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261481AbULYEUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 23:20:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Wj63bv0epTKFeyGYB3my3KHyJkZFzSixWS8HM6v4Zr3RudyXDqj+GqB1FeMt9OYFiKbdfz2j4LEp//1nckSK4Bc65JnWWa98aQhbBwJwNLPz2mN9onFrdEbOq0tkvObg74j2tPm5oHcorFioqqXDuB6ORF6KXoUFGvXfi5DcSBw=
Message-ID: <72c6e3790412242020482eadbe@mail.gmail.com>
Date: Sat, 25 Dec 2004 09:50:23 +0530
From: linux lover <linux.lover2004@gmail.com>
Reply-To: linux lover <linux.lover2004@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Understanding how kernel functions works and adding new one
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,
         I want to know what things are require me to add my own
function in kernel through modules?
          Actually i  have 2 questions in my mind
       1) Is it possible to write own user defined function in kernel
modules and get in laoded in kernel and allow kernel to use it?
       2) Is it possible to add my own function program in C file to
kernel and allow my kernel module to use it?
       I want to add own function not any system call(Am i
misunderstanding between syscall and new function call in kernel?)
         Can anybody correct me in above approaches?Also give me steps
to do that adding functions in kernel/kernel module?
Thanks in advance.
regards,
linux.lover
