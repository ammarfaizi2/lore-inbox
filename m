Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131903AbQKZAQh>; Sat, 25 Nov 2000 19:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131937AbQKZAQS>; Sat, 25 Nov 2000 19:16:18 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:17156 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S131903AbQKZAQB>;
        Sat, 25 Nov 2000 19:16:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Android" <android@turbosport.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Questions about Kernel 2.4.0.? 
In-Reply-To: Your message of "Sat, 25 Nov 2000 14:20:39 -0800."
             <001e01c0572d$f18a6e60$19211518@vnnys1.ca.home.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 Nov 2000 10:45:52 +1100
Message-ID: <10338.975195952@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000 14:20:39 -0800, 
"Android" <android@turbosport.com> wrote:
>There is a link in /lib/modules/2.4.0.11: build->/usr/src/linux
>created by the Makefile (make modules_install).
>What for? depmod doesn't like this link. It gets confused.

grep modutils Documentation/Changes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
