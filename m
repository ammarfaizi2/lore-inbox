Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290875AbSARXXT>; Fri, 18 Jan 2002 18:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290874AbSARXXK>; Fri, 18 Jan 2002 18:23:10 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:9995 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S290871AbSARXWx>;
	Fri, 18 Jan 2002 18:22:53 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: Your message of "Fri, 18 Jan 2002 17:20:02 CDT."
             <Pine.LNX.4.44.0201181632000.18867-100000@filesrv1.baby-dragons.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Jan 2002 10:22:43 +1100
Message-ID: <14160.1011396163@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002 17:20:02 -0500 (EST), 
"Mr. James W. Laferriere" <babydr@baby-dragons.com> wrote:
>	Linux doesn't have a method to load encrypted & signed modules at
>	this time .

And never will.  Who loads the module - root.  Who maintains the list
of signatures - root.  Who controls the code that verifies the
signature - root.

Your task Jim, should you choose to accept it, is to make the kernel
distinguish between a good use of root and a malicious use by some who
has broken in and got root privileges.  When you can do that, then we
can add signed modules.

