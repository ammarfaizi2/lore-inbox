Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261933AbREQPT2>; Thu, 17 May 2001 11:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261935AbREQPTS>; Thu, 17 May 2001 11:19:18 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:34569 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261933AbREQPTF>;
	Thu, 17 May 2001 11:19:05 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: make menuconfig - cosmetic question 
In-Reply-To: Your message of "Thu, 17 May 2001 16:07:40 +0200."
             <3B03DB2C.1AC5D217@TeraPort.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 18 May 2001 01:18:57 +1000
Message-ID: <8652.990112737@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001 16:07:40 +0200, 
"Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de> wrote:
>This is a multi-part message in MIME format.

Please turn off MIME when sending to linux-kernel, especially those
useless vcards at the end of your mail.

> When I diff config files pocessed by "make [old]config" and "make
>menueconfig", it seems that menuconfig is not writing out some of the
>"comments" that the other versions do write.

Congratulations, you have found reason #93 for replacing the current
configuration system (CML1) with something better - CML1 has multiple
parsers with subtly different rules and output.  CML2 will fix this, in
kernel 2.5.

