Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293178AbSBWStg>; Sat, 23 Feb 2002 13:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293177AbSBWSt1>; Sat, 23 Feb 2002 13:49:27 -0500
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:39105 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S293174AbSBWStP>; Sat, 23 Feb 2002 13:49:15 -0500
Date: Sat, 23 Feb 2002 19:49:16 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: floppy in 2.4.17
Message-ID: <20020223184916.GA1518@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020223160544.A1905@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020223160544.A1905@werewolf.able.es>
User-Agent: Mutt/1.5.0i (Linux 2.4.18-pre9-mjc2 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Feb 23 2002, J.A. Magallon wrote:

> I am getting problems with floppy drive in 2.4.17.
> All started with floppy not working in 18-rc4, went back to 17
> and still does not work. Just plain 2.4.17, no patching.
 
> mkfs -v -t ext2 /dev/fd0 gives:
 
> mke2fs 1.26 (3-Feb-2002)
> mkfs.ext2: bad blocks count - /dev/fd0

Exactly the same thing here.

-- 
# Heinz Diehl, 68259 Mannheim, Germany
