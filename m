Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSFYRPJ>; Tue, 25 Jun 2002 13:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSFYRPI>; Tue, 25 Jun 2002 13:15:08 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:11421 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S315709AbSFYRPH>; Tue, 25 Jun 2002 13:15:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: buffer layer error in 2.5.24
Date: Tue, 25 Jun 2002 19:18:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20020624214812Z315334-22020+10139@vger.kernel.org> <3D18A27C.F96BF474@zip.com.au>
In-Reply-To: <3D18A27C.F96BF474@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020625171507Z315709-22020+10462@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 June 2002 19:03, Andrew Morton wrote:
> Rudmer van Dijk wrote:
> > Hi,
> >
> > 2.5.24 with 2.5.24-kg3 applied
> >
> > got this error:
> > buffer layer error at page-writeback.c:524
>
> What filesystems are you using there?  tmpfs?

ext2 (1 partition), ext3 (1 partition) and reiserfs (3 partitions)
so no tmpfs...

	Rudmer
