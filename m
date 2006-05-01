Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWEAMyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWEAMyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 08:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWEAMyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 08:54:22 -0400
Received: from uproxy.gmail.com ([66.249.92.171]:64519 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932081AbWEAMyV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 08:54:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TNrGxCjWn6Nin8O3PlpMNclmM2y+hipkZTLEsnw55hGLGage3D+XAiZbtHnB8/HsHDhxtFj4sBwM/PXZZxCT7+d6kkaGYIQKB/GbsiNPtho5ygHaYPLWa/YTM+GJQa5DWW/6joCeIVBFOft6JHhHuOCB3CEs+wxzBzNz7SuCA4g=
Message-ID: <625fc13d0605010554l4cadac0fxe7fbc6cd5d57c679@mail.gmail.com>
Date: Mon, 1 May 2006 07:54:17 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc3-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060501014737.54ee0dd5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060501014737.54ee0dd5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc3/2.6.17-rc3-mm1/
>
>
> - Added git-rbtree.patch to the -mm lineup (David Woodhouse).  It shrinks
>   the rb-tree nodes.
>
> - Added git-sas.patch to the -mm lineup (James Bottomley).  aic94xx serial
>   attached storage driver.
>
> - Added git-supertrak.patch to the -mm lineup (Jeff Garzik).  A driver for
>   Promise SuperTrak controllers, from Promise.

Hi Andrew,

Any specific reasons the header cleanup trees weren't added?  I had
thought David asked for these to be included.  Perhaps my memory fails
me...

http://git.infradead.org/?p=hdrcleanup-2.6.git;a=summary

and

http://git.infradead.org/?p=hdrinstall-2.6.git;a=summary

thx,
josh
