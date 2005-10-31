Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVJaTam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVJaTam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVJaTal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:30:41 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:7439 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932103AbVJaTal convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:30:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QOqpAZl/Tsbe9zZIn0/W7i08B4dfsk7DUYWHpyx559/wxynB0x6yYxAtaEp5k4T0ilOwt6KfKyIKtwmAAQRmujN6YcUyuvi/J+vo24Y+zKnMId+FmteKIdFtiEQ0vKZiJsuv2KP+KGSEpmyahD0H3x/iqpwpa+LDThVptfo4cgg=
Message-ID: <71e16e3c0510311130v1d924733qeff864bb9ada93b4@mail.gmail.com>
Date: Mon, 31 Oct 2005 14:30:40 -0500
From: Yuval <yuvalfl@gmail.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [Linux-NTFS-Dev] [2.6-GIT] NTFS: Release 2.1.25.
Cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/05, Anton Altaparmakov wrote:
> What this means is that you can now run your favourite editor on an
> existing file, e.g. "vim /ntfs/somefile.txt" works fine and you can save
> your changes.  Also things like running OpenOffice and editing existing MS
> Office documents works.  Basically anything that does not need to create
> temporary files in the same directory as the document should work fine
> now.

How is possible to use a text editor? Aren't most of them use a temporary file?
I spent some time ago documenting it in
http://wiki.linux-ntfs.org/doku.php?id=texteditorpitfall after it came
up on the linux-ntfs-dev mailing list (long ago). Am I wrong?

I remember Rich writing about some command of vim to disable the
temporary file feature, but you haven't mentioned that one, so I
assume it works for you "out-of-the-box".

Sincerely
-- Yuval
