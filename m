Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136082AbREBXXm>; Wed, 2 May 2001 19:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136088AbREBXXd>; Wed, 2 May 2001 19:23:33 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:21255 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136082AbREBXXU>;
	Wed, 2 May 2001 19:23:20 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: joe.mathewson@btinternet.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Logging kernel oops 
In-Reply-To: Your message of "Wed, 02 May 2001 20:57:16 +0100."
             <200105021957.f42JvH511805@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 May 2001 09:23:12 +1000
Message-ID: <5151.988845792@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 May 2001 20:57:16 +0100, 
"Joseph Mathewson" <joe@mathewson.co.uk> wrote:
>What is the preferred what of getting debugging information from a kernel
>oops?  Is my only way connecting a monitor and getting a pencil and paper? 
>Is there any conceivable way I can get some useful debugging information
>(on reset) without plugging in a keyboard/monitor?

Add a serial console (linux/Documentation/serial-console.txt) and
install the kernel debugger of your choice.  kdb is good ;)
http://oss.sgi.com/projects/kdb/download

