Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314583AbSEMXGj>; Mon, 13 May 2002 19:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314612AbSEMXGi>; Mon, 13 May 2002 19:06:38 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26646 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314583AbSEMXGh>; Mon, 13 May 2002 19:06:37 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200205132306.g4DN6bb04733@devserv.devel.redhat.com>
Subject: Re: Wine problems w/ 2.4.19-pre8-ac1
To: aibara@ucsd.edu
Date: Mon, 13 May 2002 19:06:37 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020513210339.GA8045@thibs.menloschool.org> from "Allen H. Ibara" at May 13, 2002 02:03:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to report that vm86 handling still seems to be broken as
> of 2.4.19-pre8-ac1.
> 
> Wine does not work properly until I copy arch/i386/kernel/vm86.c over from
> a vanilla 2.4.18 tree (Although dosemu works fine without this).

What sort of problems does it show ?
