Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316163AbSFPLT7>; Sun, 16 Jun 2002 07:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSFPLT6>; Sun, 16 Jun 2002 07:19:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:41964 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316163AbSFPLT5>; Sun, 16 Jun 2002 07:19:57 -0400
Date: Sun, 16 Jun 2002 13:19:54 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Brian Gerst <bgerst@didntduck.org>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
In-Reply-To: <287160000.1020816859@flay>
Message-ID: <Pine.NEB.4.44.0206161317410.11043-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

this problem with CONFIG_MULTIQUAD does also exist in 2.4 kernels. Could
you provide a patch against 2.4.19-pre10?

TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


