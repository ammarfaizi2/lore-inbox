Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130854AbQLTEMK>; Tue, 19 Dec 2000 23:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130873AbQLTELu>; Tue, 19 Dec 2000 23:11:50 -0500
Received: from quechua.inka.de ([212.227.14.2]:3896 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130854AbQLTELo>;
	Tue, 19 Dec 2000 23:11:44 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/random: really secure?
Message-Id: <E148a7v-0001Ub-00@calista.inka.de>
Date: Wed, 20 Dec 2000 04:41:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001218213801.A19903@pcep-jamie.cern.ch> you wrote:
> A potential weakness.  The entropy estimator can be manipulated by
> feeding data which looks random to the estimator, but which is in fact
> not random at all.

That's why feeding randomness is a priveledgedoperation.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
