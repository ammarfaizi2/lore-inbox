Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUDBXhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 18:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUDBXhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 18:37:21 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:63497 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261361AbUDBXhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 18:37:16 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: elevators
Date: Sat, 3 Apr 2004 01:37:08 +0200
User-Agent: KMail/1.6.1
Cc: Fabian Frederick <Fabian.Frederick@skynet.be>
References: <1080946656.4484.5.camel@linux.local>
In-Reply-To: <1080946656.4484.5.camel@linux.local>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404030137.08733@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 April 2004 00:57, Fabian Frederick wrote:

Hi Fabian,

>         I've been testing cfq against standard elevator under
> 2.6.5rc3-mm4 with dbench and I've been surprised by high variations
>  there.Someone could tell me if there are a lot of elevator patches
> available to compare ?

less Documentation/kernel-parameters.txt

...

        elevator=       [IOSCHED]
                        Format: {"as"|"cfq"|"deadline"|"noop"}
                        See Documentation/as-iosched.txt for details

imho there are no more elevator patches out there.

ciao, Marc
