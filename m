Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316919AbSFFNTe>; Thu, 6 Jun 2002 09:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316953AbSFFNTd>; Thu, 6 Jun 2002 09:19:33 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:5871 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316919AbSFFNTd>; Thu, 6 Jun 2002 09:19:33 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020604003803.GA1705@werewolf.able.es> 
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.19-pre9-jam1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jun 2002 14:19:33 +0100
Message-ID: <6408.1023369573@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jamagallon@able.es said:
> 30-shared-zlib.bz2
> 	Use only one copy of zlib for whole kernel.
> 	Authonr: David Woodhouse <dwmw2@infradead.org>
> 	URL: ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/linux-2.4.19-shared-zlib.bz2 

Please update this to the latest version (linux-2.4.19-pre10-shared-zlib), 
which fixes the zisofs and include path problems.

Each of those two one-line patches can be found at
http://linux-mtd.bkbits.net:8080/zlib-2.4

--
dwmw2


