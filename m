Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288050AbSAVRRP>; Tue, 22 Jan 2002 12:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288153AbSAVRQ5>; Tue, 22 Jan 2002 12:16:57 -0500
Received: from smtp-out.student.liu.se ([130.236.230.80]:45374 "EHLO
	arcadia.student.liu.se") by vger.kernel.org with ESMTP
	id <S288050AbSAVRQo>; Tue, 22 Jan 2002 12:16:44 -0500
Date: Tue, 22 Jan 2002 18:16:36 +0100
From: Erik Gustavsson <cyrano@algonet.se>
Subject: Re: preemption and pccard ?
In-Reply-To: <20020122041802.8E8208954D@cx518206-b.irvn1.occa.home.com>
To: linux-kernel@vger.kernel.org
Message-id: <1011719797.3764.12.camel@bettan>
MIME-version: 1.0
X-Mailer: Evolution/1.0.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
In-Reply-To: <20020122041802.8E8208954D@cx518206-b.irvn1.occa.home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I also saw this when trying a preempt kernel somewhere in the
2.4.17pre series. Only one cardbus slot worked (I think it was the
bottom slot that didn't respond, but I could be mistaken). I was playing
around with various patches at the time, so I didn't pay much attention
to it. I can try to verify it if that would help. This was on a Dell
Latitude CPi D266XT.

/cyr
 
-- 
-----------------------------------------------------------------------
You really think you can buy me with promises of power and glory.
You really think... Okay, I'll do it. -- Rimmer

