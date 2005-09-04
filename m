Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVIDToJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVIDToJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 15:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVIDToJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 15:44:09 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:55781 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751048AbVIDToI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 15:44:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l4Vh9KJ3RPa0YnTxaoazxBZJZCGrKSzqzZtoDET5LoTAOrtT/0mL/ai2DDfMksCmPoXQIDphXtuz2EnSUmnt7FlSXKnUhW6cy6KjuUP54UmU3gI+mzAtAloUJEjLoVdxIbetuDwi9d8rKfVs9ZWGJQJXoQLI3uaFL0Hbm71g2bc=
Message-ID: <dda83e78050904124454fc675a@mail.gmail.com>
Date: Sun, 4 Sep 2005 12:44:05 -0700
From: Bret Towe <magnade@gmail.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: nfs4 client bug
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050904103523.GA5613@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dda83e78050903171516948181@mail.gmail.com>
	 <dda83e7805090320053b03615d@mail.gmail.com>
	 <20050904103523.GA5613@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Francois Romieu <romieu@fr.zoreil.com> wrote:
> Bret Towe <magnade@gmail.com> :
> [...]
> > after moving some files on the server to a new location then trying to
> > add the files
> > to xmms playlist i found the following in dmesg after xmms froze
> > wonder how many more items i can find...
> 
> The system includes some binary only stuff. Please contact your vendor
> or provide the traces for a configuration wherein the relevant module
> was not loaded after boot. It may make sense to get in touch with
> nfs@lists.sourceforge.net then.

the 'binary only stuff' is ati-drivers kernel module and it crashs
with or without it
ill provide a 'untainted' trace as soon as i can repeat the bug again
 
> --
> Ueimor
>
