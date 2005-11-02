Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965329AbVKBWkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329AbVKBWkI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbVKBWkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:40:07 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:57438 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965329AbVKBWkF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:40:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O1f9htknsh0h2P7lBL5k3J87q6lDwGh+CuKSrKIvnr+h8EuTpcpDdbPbXaewTKkQnDOLcMzAAeB2aBCoL1pu5rux5YxuXykvoMRIWG4QNCvjKdC7EYW0VxBNBccSl/qbevVtieEyUidUnPZcCh4+vJncN+V8AJjHo0i0AHwBLa8=
Message-ID: <fe726f4e0511021440xdb80808p@mail.gmail.com>
Date: Thu, 3 Nov 2005 00:40:04 +0200
From: Carlos Martin <carlosmn@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: sharp zaurus-5500: looking for testers
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051102000003.GA467@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20051102000003.GA467@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/05, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> Is there someone out there, with sharp zaurus sl-5500, willing to test
> kernels? There's a linux-z tree on kernel.org, which I try to more or
> less keep in sync with mainline, that is slowly starting to get
> usable. It could use some testing.

I cloned your tree but it said one of the packs wasn't in the index. I
don't have the exact error message, sorry. I'll try again tomorrow.
Also your git tree (repository?) in kernel.org is a bit broken. The
git web interface gives me 403 error when I try to see a diff in your
zaurus.git tree, and there's stuff that appears to be missing (history
and commits).

>
> Main drawback is that battery charging is not yet done; touchscreen is
> there but I did not have chance to test it with proper userspace
> filtering.

Does this mean the battery won't get charged when using the 2.6
kernel, or that it won't get reported?

   cmn
--
Carlos Martín Nieto        http://www.cmartin.tk

"¿Han entendido?"
"Sí, nosotros vemos La 2" -- Emilio, "Aquí no hay quien viva"
