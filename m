Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSCRQiB>; Mon, 18 Mar 2002 11:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSCRQhs>; Mon, 18 Mar 2002 11:37:48 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:13298 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S287204AbSCRQha>; Mon, 18 Mar 2002 11:37:30 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020318144946.GA7052@werewolf.able.es> 
To: "J.A. Magallon" <jamagallon@able.es>
Cc: paulus@samba.org, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 18 Mar 2002 16:36:27 +0000
Message-ID: <28998.1016469387@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jamagallon@able.es said:
>  Someone posted it was here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/shared-zlib/ 

Also bk://linux-mtd.bkbits.net/zlib-2.4 and in 2.4.19-ac.

After it's been in -ac for a while without mishap I'll ask Marcelo to
consider it - possibly for 2.4.20-pre1.

--
dwmw2


