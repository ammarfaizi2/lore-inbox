Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWEaGvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWEaGvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWEaGvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:51:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964846AbWEaGvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:51:13 -0400
Date: Tue, 30 May 2006 23:55:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: raph@raphnet.net, alessandro.zummo@towertech.it,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add max6902 RTC support
Message-Id: <20060530235500.edc9ef49.akpm@osdl.org>
In-Reply-To: <1149057131.7461.40.camel@localhost.localdomain>
References: <20060530150913.GE797@aramis.lan.raphnet.net>
	<20060530203241.4a4de734@inspiron>
	<20060530184949.GF797@aramis.lan.raphnet.net>
	<20060530150143.7e39dac3.akpm@osdl.org>
	<1149057131.7461.40.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 07:32:11 +0100
Ian Campbell <ijc@hellion.org.uk> wrote:

> On Tue, 2006-05-30 at 15:01 -0700, Andrew Morton wrote:
> > That's a problem.  According to the Developer's Certificate of Origin
> > process we'd need "Someone at Compulab" to send us a Signed-off-by:, along
> > with the assertions which that carries.
> 
> Don't clauses (a) and/or (b) include provisions that mean Raphael takes
> on this responsibility if he believes that CompuLab released the patch
> under a suitable open source license? In particular the "to the best of
> my knowledge, is covered under an appropriate open source license" bit
> in (b).

hm, sometimes it helps to read things.

>         (a) The contribution was created in whole or in part by me and I
>         have the right to submit it under the open source license
>         indicated in the file; or
>         
>         (b) The contribution is based upon previous work that, to the
>         best of my knowledge, is covered under an appropriate open
>         source license and I have the right under that license to submit
>         that work with modifications, whether created in whole or in
>         part by me, under the same open source license (unless I am
>         permitted to submit under a different license), as indicated in
>         the file; or

Yes, I think that would work, if Rafael is prepared to make that assertion.

If so, please send along a few words describing where the Compulab code
came from and some substantiation of your belief that it was appropriately
licensed.  (It probably had some license words at the top of the file..)
