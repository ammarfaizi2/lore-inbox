Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267762AbTBRMlC>; Tue, 18 Feb 2003 07:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267775AbTBRMlB>; Tue, 18 Feb 2003 07:41:01 -0500
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:23529 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S267762AbTBRMlB>; Tue, 18 Feb 2003 07:41:01 -0500
Message-Id: <4.3.2.7.2.20030218181634.01fb5428@desh>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 18 Feb 2003 18:20:51 +0530
To: linux-kernel@vger.kernel.org
From: Sudharsan Vijayaraghavan <svijayar@cisco.com>
Subject: Help !! calling function in module from a user program 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am a new bee to linux internals.
I am trying to make a simple program witch will call a function from a 
module. I made a module compiled it and INSMOD-it into kernel, that works 
fine. I would like to call from my user program a function defined in my 
kernel module.

Please suggest any method thro' which this could be accomplished.
The only way i did it was by running my new module as insmod mymodule.o and 
get my job done.

Thanks,
Sudharsan.

