Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSCSUf7>; Tue, 19 Mar 2002 15:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSCSUft>; Tue, 19 Mar 2002 15:35:49 -0500
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:59334
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S292588AbSCSUfm>; Tue, 19 Mar 2002 15:35:42 -0500
Date: Tue, 19 Mar 2002 15:35:27 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zlib double-free bug
In-Reply-To: <a77umb$t3s$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0203191533360.3615-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Mar 2002, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX.4.44.0203191044150.26226-100000@passion.cambridge.redhat.com>
> By author:    David Woodhouse <dwmw2@redhat.com>
> In newsgroup: linux.dev.kernel
> >
> > For the record - it's not worth bothering with fs/jffs2/zlib.c; if they 
> > can corrupt your file system on the medium, why bother with cracking zlib? 
> > :)
> > 
> 
> Removable media?

Most if not all removable media are not ment to be used with JFFS2.


Nicolas

