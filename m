Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285935AbSBGIAn>; Thu, 7 Feb 2002 03:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbSBGIAe>; Thu, 7 Feb 2002 03:00:34 -0500
Received: from borderworlds.dk ([193.162.142.101]:41478 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S285935AbSBGIAS>; Thu, 7 Feb 2002 03:00:18 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with iso9660 as initrd
In-Reply-To: <m3r8ny8by5.fsf@borg.borderworlds.dk>
	<a3sei4$h5p$1@cesium.transmeta.com>
From: Christian Laursen <xi@borderworlds.dk>
Date: 07 Feb 2002 09:00:16 +0100
In-Reply-To: <a3sei4$h5p$1@cesium.transmeta.com>
Message-ID: <m3n0yl90xb.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <m3r8ny8by5.fsf@borg.borderworlds.dk>
> By author:    Christian Laursen <xi@borderworlds.dk>
> In newsgroup: linux.dev.kernel
> > 
> > Am I doing something terribly unusual, or just something wrong here?
> > 
> 
> Also, you don't have CONFIG_ZISOFS set...

Sorry for not being precise enough. It is not a zisofs, just compressed
with gzip as usual for an initrd image.

-- 
Best regards
    Christian Laursen
