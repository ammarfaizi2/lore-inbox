Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSDENgz>; Fri, 5 Apr 2002 08:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSDENgq>; Fri, 5 Apr 2002 08:36:46 -0500
Received: from cpath.psinet.cl ([200.14.80.251]:414 "EHLO cpath.psinet.cl")
	by vger.kernel.org with ESMTP id <S312616AbSDENgc>;
	Fri, 5 Apr 2002 08:36:32 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Mauricio =?iso-8859-1?q?Nu=F1ez?= <mnunez@maxmedia.cl>
To: Piotr Esden-Tempski <pe1724@bingo-ev.de>, joeja@mindspring.com
Subject: Re: faster boots?
Date: Fri, 5 Apr 2002 09:37:52 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net> <20020405004419.GA26692@bingo-ev.de>
MIME-Version: 1.0
Message-Id: <02040509375201.02441@mauricio.chile.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try UPX unstable to compress the kernel. The decompression routine is faster 
than actual kernel routine.

http://upx.sf.net

Mauricio Nuñez
mnunez@maxmedia.cl
