Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSFFXiX>; Thu, 6 Jun 2002 19:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315461AbSFFXiW>; Thu, 6 Jun 2002 19:38:22 -0400
Received: from wotug.org ([194.106.52.201]:35682 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S315429AbSFFXiV>;
	Thu, 6 Jun 2002 19:38:21 -0400
Date: Fri, 7 Jun 2002 00:38:10 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Docu-PATCH] Updated docu for srm_env.o driver
In-Reply-To: <20020605110352.GP20788@lug-owl.de>
Message-ID: <Pine.LNX.4.44.0206070034120.17054-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Jan-Benedict Glaw wrote:

>Please apply this patch. It updates the documentation to my driver.
>
>+  If you enable this option, you'll find all important SRM environment
>+  variables in /proc/srm_environment/named_variables/. In addition to
>+  this, you can access any custom variable through its assigned number
>+  in /proc/srm_environment/numbered_variables/. If you want to access
>+  your SRM environment (or if you're building a generic kernel for
>+  distribution) it's a good idea to say Y or M to this driver.
> 
>+  If you build it as a module, the resulting file will be srm_env.o.

After reading this, I still don't know what SRM is. Could you possibly expand 
SRM in the first line so it makes sense for te not-so-clued-up? E.g.:


"If you enable this option, the important Silly Random Memo (SRM) confguration
settings are stored in /proc/srm_environment/  ..."



Thanks,

Ruth


-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

