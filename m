Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282014AbRKVCfi>; Wed, 21 Nov 2001 21:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282015AbRKVCf2>; Wed, 21 Nov 2001 21:35:28 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:49927 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282014AbRKVCfW>;
	Wed, 21 Nov 2001 21:35:22 -0500
Date: Thu, 22 Nov 2001 00:34:28 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Jeff Merkey" <jmerkey@timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NetWare File System NWFS 2.4.15-pre8 Kernel Patch
Message-ID: <20011122003428.B2216@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Jeff Merkey" <jmerkey@timpanogas.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <000d01c172fc$cde53440$f5976dcf@nwfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000d01c172fc$cde53440$f5976dcf@nwfs>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 21, 2001 at 07:24:25PM -0700, Jeff Merkey escreveu:
> 
> A Kernel patch that integrate the NetWare File System (NWFS) into the
> 2.4.15-pre8 kernel has been posted at
> ftp.timpanogas.org:/nwfs/nwfs-2.4.15-pre8-1.bz2 and
> ftp.utah-nac.org:/nwfs/nwfs-2.4.15-pre8-1.bz2
> 
> This patch includes support for the 3Ware RAID Adapter and Linux Software
> RAID.

Why don't you release three separate patches? One for NWFS, another for the
3Ware controle and another for the Soft RAID? And please send it to the
respective maintainers. I'm assuming that the two later patches are not
related to NWFS, if not, please apologize.

- Arnaldo
