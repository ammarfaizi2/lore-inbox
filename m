Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTDXL11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTDXL11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:27:27 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:39578 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263494AbTDXL1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:27:25 -0400
Message-ID: <3EA7CCD3.7090603@shemesh.biz>
Date: Thu, 24 Apr 2003 14:38:59 +0300
From: Shachar Shemesh <lkml@shemesh.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en, he
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com> <1051174641.1385.4.camel@laptop.fenrus.com> <20030424101903.C9597@flint.arm.linux.org.uk>
In-Reply-To: <20030424101903.C9597@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>You just arrange for the script to detect whether a private key is
>present.  If none exists, it asks the user whether they want to generate
>a private key, and then calls gpg with the relevant options to do so.
>
>The private key isn't part of the script, nor is it a requirement to
>be able to (successfully) run the script.
>
>Note that the GPL does not say whether the output from the installation
>script has to be usable with the target hardware.
>
>  
>
>On Thu, Apr 24, 2003 at 10:57:21AM +0200, Arjan van de Ven wrote:
>  
>
>For an executable work, complete source code means all the source code
>for all modules it contains, plus any associated interface definition
>files, plus the scripts used to control compilation and installation of
>the executable.
>  
>
Wouldn't "control ... installation" include the keys too?

IANAL, but I am on the board of an NPO that advocates Free and Open 
Source Software, and that NPO has a lawyer (who is VERY familiar with 
the GPL). Would it make sense to ask him? After all, that merely means 
what one lawyer would say.

-- 
Shachar Shemesh
Open Source integration consultant
Home page & resume - http://www.shemesh.biz/


