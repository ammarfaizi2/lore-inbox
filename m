Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWDWH3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWDWH3D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 03:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWDWH3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 03:29:01 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:3817 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751354AbWDWH3B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 03:29:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SNnOHs5JveOCukROb64QUMPlSpO0qKOkZ6oE8+o0jALmy0SEySAQ+JnfJFxySfPG176OIlBFiZZ1FG3lxV6gU3cXxPOO8mcr4uo7emAV6+U2NAVCjlRiCVFGEWLIcFpKEgMONc+1yt6Jj4mSJp7zoSOmCsRHGrPeCZYHiW1RTQA=
Message-ID: <b3be17f30604230029laa51c7fkc64920180542379d@mail.gmail.com>
Date: Sun, 23 Apr 2006 00:29:00 -0700
From: "Robert Merrill" <grievre@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: NFS bug?
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1145648087.8165.23.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b3be17f30604200937l7cfaca8evcc17f6ecd72f643e@mail.gmail.com>
	 <1145555789.8136.13.camel@lade.trondhjem.org>
	 <b3be17f30604201102jff51794r52dd3024d631051e@mail.gmail.com>
	 <1145556613.8136.14.camel@lade.trondhjem.org>
	 <b3be17f30604201114n7a50bad9u6f3839a029f571a7@mail.gmail.com>
	 <1145560845.8136.26.camel@lade.trondhjem.org>
	 <20060421005524.15f1c414.akpm@osdl.org>
	 <1145628470.8150.10.camel@lade.trondhjem.org>
	 <20060421113156.35c626dc.akpm@osdl.org>
	 <1145648087.8165.23.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, please check that the kernel was compiled with
> CONFIG_FRAME_POINTER and CONFIG_KALLSYMS.

Don't have the former
