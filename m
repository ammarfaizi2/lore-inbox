Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287276AbSA2Xyz>; Tue, 29 Jan 2002 18:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287163AbSA2XxS>; Tue, 29 Jan 2002 18:53:18 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:61145 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S287145AbSA2Xwq>;
	Tue, 29 Jan 2002 18:52:46 -0500
Date: Wed, 30 Jan 2002 00:52:34 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.2-dj7
In-Reply-To: <20020130003346.A16379@suse.de>
Message-ID: <Pine.GSO.4.30.0201300047200.940-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > > 2.5.2-dj7
>  > > o   Workaround some broken PS/2 mice.			(Vojtech Pavlik)
>  > What is this about exactly?
>
>  Some PS2 mice forget to ACK the GetID command before sending
>  a response.

I just asked, because sometimes gpm can lock up my keyboard if it cannot
read psaux. (it's 2.4) Might it be related?

-- 
pozsy


