Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265164AbUELStj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265164AbUELStj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUELStj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:49:39 -0400
Received: from ccs.covici.com ([209.249.181.196]:40578 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id S265164AbUELSth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:49:37 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.6 breaks VMware compile..
References: <407CF31D.8000101@rgadsdon2.giointernet.co.uk>
From: John Covici <covici@ccs.covici.com>
Date: Wed, 12 May 2004 14:49:35 -0400
In-Reply-To: <407CF31D.8000101@rgadsdon2.giointernet.co.uk> (Robert
 Gadsdon's message of "Wed, 14 Apr 2004 09:15:25 +0100")
Message-ID: <m365b15vls.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do Iget that patch since its still broke in 2.6.6?

Thanks.

on Wed, 14 Apr 
2004 09:15:25 +0100 Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk> wrote:

> 2.6.5-bk1 breaks the VMware compile (similar problem with
>     2.6.5-mm5). This is fixed by Sam Ravnborg's kbuild patch (see
>     previous LKML message).   This should also fix problems with
>     broken Nvidia (non-free) compiles..
>
>
> Robert Gadsdon.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
         John Covici
         covici@ccs.covici.com
