Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318741AbSHGP4x>; Wed, 7 Aug 2002 11:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318749AbSHGP4x>; Wed, 7 Aug 2002 11:56:53 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51194 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318741AbSHGP4w>; Wed, 7 Aug 2002 11:56:52 -0400
Subject: Re: 2.4.20-pre1-ac1: apm.c non SMP compile error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       list linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <laughing@shared-source.org>
In-Reply-To: <20020807151508.GA6127@louise.pinerecords.com>
References: <3D511AD8.3C7CF2A7@eyal.emu.id.au> 
	<20020807151508.GA6127@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 18:19:32 +0100
Message-Id: <1028740772.18156.313.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 16:15, Tomas Szepe wrote:
> or alternatively the following, which for the cost of a couple ifdefs
> also removes the unused variable 'cpus' on UP:

The compiler will do that for us anyway

