Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274972AbRIYLui>; Tue, 25 Sep 2001 07:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274974AbRIYLu2>; Tue, 25 Sep 2001 07:50:28 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:60944 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274972AbRIYLuR>;
	Tue, 25 Sep 2001 07:50:17 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem compiling 2.4.9 kernel (fwd) 
In-Reply-To: Your message of "Tue, 25 Sep 2001 16:16:49 +0530."
             <Pine.LNX.4.10.10109251616130.3864-100000@blrmail> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Sep 2001 21:50:33 +1000
Message-ID: <14236.1001418633@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001 16:16:49 +0530 (IST), 
"SATHISH.J" <sathish.j@tatainfotech.com> wrote:
>I compiled the linux 2.4.9 kernel with the kdb patch "kdb-v1.8-2.4.9" got
>/bin/sh: /sbin/kallsyms: No such file or directory

Read Documentation/Changes, your modutils is too old.

