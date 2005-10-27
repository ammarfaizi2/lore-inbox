Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVJ0PJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVJ0PJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVJ0PJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:09:56 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:4622 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750980AbVJ0PJz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:09:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SSp1ZyPVh7QWZdyxBhb1v0pkwnye8xBlCUCXFB0quNkZz8m3d+hlmXBtbRx9NKhMZWYYLUHL6vVuCF7e/v4u+b0X+fp1Gw/1tVQuKJHETlwTFk/MU9RMEQBL0aQGtwkT+1o4WJszNbCMuB7yDjQJwok4gbPUjgLFXzL6bTvdJSE=
Message-ID: <35fb2e590510270809k4b1797d7q690c0be5f330ce64@mail.gmail.com>
Date: Thu, 27 Oct 2005 16:09:54 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Linux Kernel MD5 sums and some question
Cc: Chaitanya Hazarey <c.v.hazarey@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490510270423x45ffd8c8v773055f5369fe468@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a9abfb40510262356o5de2a638pa15d0c8e9dda2833@mail.gmail.com>
	 <9a8748490510270423x45ffd8c8v773055f5369fe468@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 10/27/05, Chaitanya Hazarey <c.v.hazarey@gmail.com> wrote:

> > Lately I had some problems compiling the kernel source on my machine.
> > I guess nothing serious, but one thing came to my notice. I was
> > looking for the MD5 sums for the linux kenerl and found none. The Pgp
> > signatures are fine , but there seems no way to check the package.

> Yes, there is a way to check the files; verify the pgp signature. If
> the file has been modified the signature won't validate.

But having signed MD5 sums would be a solution.

That way people can check a). Did they download the kernel properly?
b). Was it genuine? in two distinct steps. Others will think that's a
*really* bad idea :-)

Jon.
