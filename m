Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbRAKLlF>; Thu, 11 Jan 2001 06:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRAKLkz>; Thu, 11 Jan 2001 06:40:55 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:47109 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S130026AbRAKLkm>;
	Thu, 11 Jan 2001 06:40:42 -0500
Date: Thu, 11 Jan 2001 13:40:30 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: Darryl Miles <darryl@netbauds.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0: Small observation in /proc/sys/net/unix/
In-Reply-To: <3A5D9A82.2568646B@netbauds.net>
Message-ID: <Pine.LNX.4.30.0101111339370.30013-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Darryl Miles wrote:
> # ls -il /proc/sys/net/unix/
> total 24
>    4446 -rw-------   1 root     root            0 Jan 11 11:06
> max_dgram_qlen
>    4446 -rw-------   1 root     root            0 Jan 11 11:06
> max_dgram_qlen
>
> Identical filenames, nothing bad appears to be happening it just looks
> weird.

This has been fixed in Alan's patches.

-- Hans

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
