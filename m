Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290843AbSBXTvu>; Sun, 24 Feb 2002 14:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290839AbSBXTvk>; Sun, 24 Feb 2002 14:51:40 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:42314 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290818AbSBXTvY> convert rfc822-to-8bit; Sun, 24 Feb 2002 14:51:24 -0500
Date: Sun, 24 Feb 2002 14:46:08 +0100
From: Heinz Diehl <hd@cavy.de>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Chris Sykes <chris@sykes.uklinux.net>, linux-kernel@vger.kernel.org
Subject: Re: floppy in 2.4.17
Message-ID: <20020224134608.GA168@chiara.cavy.de>
Mail-Followup-To: Mike Fedyk <mfedyk@matchmail.com>,
	Chris Sykes <chris@sykes.uklinux.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020223160544.A1905@werewolf.able.es> <20020223184916.GA1518@chiara.cavy.de> <20020223220007.A461@cooper> <20020224030528.GQ20060@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020224030528.GQ20060@matchmail.com>
User-Agent: Mutt/1.5.0i (Linux 2.4.18-rc2-ac1 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by chiara.cavy.de id g1OJpxxk000193
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Feb 23 2002, Mike Fedyk wrote:

> So, can you guys stress the -ac patch to see if it's fixed there?

chiara:~ # mke2fs -t ext2 /dev/fd0
mke2fs 1.24, 30-Aug-2001 for EXT2 FS Lö,
mke2fs: bad blocks count - /dev/fd0

chiara:~ # uname -a
Linux chiara 2.4.18-rc2-ac1 #1 Sun Feb 24 14:20:33 CET 2002 i586 unknown
	
-- 
# Heinz Diehl, 68259 Mannheim, Germany
