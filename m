Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbSLXPxL>; Tue, 24 Dec 2002 10:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSLXPxL>; Tue, 24 Dec 2002 10:53:11 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:34316 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S264962AbSLXPxK>; Tue, 24 Dec 2002 10:53:10 -0500
Date: Tue, 24 Dec 2002 08:59:37 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: venom@sns.it, linux-kernel@vger.kernel.org
Subject: Re: aicasm: SIG 11 with 2.5.53 (new aic7xxx driver problem)
Message-ID: <2154615408.1040745577@aslan.scsiguy.com>
In-Reply-To: <Pine.LNX.4.43.0212241237480.30482-100000@cibs9.sns.it>
References: <Pine.LNX.4.43.0212241237480.30482-100000@cibs9.sns.it>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> HI,
> I was compiling new kernel 2.5.53.
> If "build adaptec formware" option is enabled, (I know I should avoid it,
> but it is a development kernel, and I am doing tests ;) ),
> compiling aic7xxx driver,
> compilation fails because
> of a segmentation fault I get running aicasm.

Can you try the driver from here?  There was a syntax error in the
assembler's grammer that might have caused this problem:

http://people.FreeBSD.org/~gibbs/linux/SRC/

--
Justin

