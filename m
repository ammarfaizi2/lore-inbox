Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSEMWmp>; Mon, 13 May 2002 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSEMWmo>; Mon, 13 May 2002 18:42:44 -0400
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:61876 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S314529AbSEMWmo>; Mon, 13 May 2002 18:42:44 -0400
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200205132242.AAA11464@faui1a.informatik.uni-erlangen.de>
Subject: Re: Strange s390 code in 2.4.19-pre8
To: kai@tp1.ruhr-uni-bochum.de, zaitcev@redhat.com
Date: Tue, 14 May 2002 00:42:38 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:

>Not sure if I understand you correctly. I mean it should work w/o 
>CONFIG_MODVERSIONS, and it would also work with CONFIG_MODVERSIONS if it 
>wasn't for the conflict with the ISDN fsm.o. Do we agree here?

As it is not possible to configure the ISDN fsm.o into a s390
build (and there is in fact no ISDN hardware for S/390 ;-/),
how can there be any conflict?

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
