Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310940AbSCLNgw>; Tue, 12 Mar 2002 08:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311195AbSCLNgo>; Tue, 12 Mar 2002 08:36:44 -0500
Received: from calhau.terra.com.br ([200.176.3.20]:63880 "EHLO
	calhau.terra.com.br") by vger.kernel.org with ESMTP
	id <S310940AbSCLNgb>; Tue, 12 Mar 2002 08:36:31 -0500
Date: Tue, 12 Mar 2002 10:36:24 -0300
From: Lucio Maciel <abslucio@terra.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] zlib double-free fix
Message-Id: <20020312103624.6b2bd486.abslucio@terra.com.br>
Organization: Absoluta
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a small patch to fix the double-free in drivers/net/zlib.c

its against 2.4.19-pre3 but works fine in others versions

-- 
::: Lucio Maciel
::: abslucio@terra.com.br
::: Absoluta.Net :::
