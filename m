Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264871AbRFYQff>; Mon, 25 Jun 2001 12:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264874AbRFYQfZ>; Mon, 25 Jun 2001 12:35:25 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:784 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264871AbRFYQfK>;
	Mon, 25 Jun 2001 12:35:10 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: joeja@mindspring.com
cc: linux-kernel@vger.kernel.org
Subject: Re: AMD thunderbird oops 
In-Reply-To: Your message of "Mon, 25 Jun 2001 12:24:11 -0400."
             <Springmail.105.993486251.0.81762700@www.springmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jun 2001 02:35:04 +1000
Message-ID: <1633.993486904@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001 12:24:11 -0400, 
joeja@mindspring.com wrote:
>   The oops says something like 'kernel null pointer at address
>0x000000'.  How do I 'catch' the output of an oops when the filesystem
>goes and I get ext2fs errors and am forced to reboot and manually run
>e2fsck?

Read linux/Documentation/oops-tracing.txt.

