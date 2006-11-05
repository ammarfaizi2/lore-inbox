Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161359AbWKERDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWKERDT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWKERDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:03:19 -0500
Received: from web38405.mail.mud.yahoo.com ([209.191.125.36]:52414 "HELO
	web38405.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161359AbWKERDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:03:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mNkBoSD3nM+aj6FsrFvEGDYJt3XTg5UsXiDsAN646LigWapjAJTWIVfTa57gs7RTGe3aF5Q2DfoZ4bTDY+KYs+w3dSjovILI+cNAQ8qYH3hSvyvimbW3COzB8zBg0N1S9FOV9Ue00qhkyGzPpktKVTSfIh2LuoLe4uzGe9O8TiU=  ;
Message-ID: <20061105170318.68879.qmail@web38405.mail.mud.yahoo.com>
Date: Sun, 5 Nov 2006 09:03:18 -0800 (PST)
From: xp newbie <xp_newbie@yahoo.com>
Subject: Re: How do I know whether a specific driver being used?
To: linux-kernel@vger.kernel.org
In-Reply-To: <653402b90611050147x5af94b50s46a5f107f29031b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Miguel Ojeda <maxextreme@gmail.com> wrote:
>
> This mailing list is about kernel development, this
> is not the right
> place to ask that. Anyway, 3rd party kernels,
> patches, drivers... are
> not covered here.
> 

I appologize for sending to the wrong mailing list.
Could you please refer me to the correct
newsgroup/forum/mailinglist?

Please note that I have already tried
http://www.ubuntuforums.org/ but the folks seem to be
confused like me (regarding this particular issue).

More specifically, there is confusion between the
following statement:

http://packages.debian.org/stable/devel/kernel-patch-2.4-fasttraks150

And the fact that my system shows the following:

~> lsmod | grep promise
sata_promise           12516  8
libata                 83440  1 sata_promise
scsi_mod              145960  6
sr_mod,sbp2,sg,sd_mod,sata_promise,libata

Do you know what the best place to ask such question?

Thanks!
Alex

P.S. I didn't browse menuconfig, because I am not
there yet. It's like the chicken-and-the-egg
situation: I am using Ubuntu which conceptually
exempts me from the need to compile kernel modules and
thus menuconfig is not even installed by default.
Since (thanks to Arjan's reply) I am pretty sure now
that the driver is included in the distribution, I
hope that no compilation is needed.

P.S.2 If I discover something that IMHO points to a
bug in the kernel, where do I post it?



 
____________________________________________________________________________________
Get your email and see which of your friends are online - Right on the New Yahoo.com 
(http://www.yahoo.com/preview) 

