Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318799AbSIISTq>; Mon, 9 Sep 2002 14:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318802AbSIISTq>; Mon, 9 Sep 2002 14:19:46 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:19391 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318799AbSIISTq>;
	Mon, 9 Sep 2002 14:19:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: <imran.badr@cavium.com>, <root@chaos.analogic.com>
Subject: Re: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 20:27:02 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "'David S. Miller'" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
References: <01a301c2582c$754dbf30$9e10a8c0@IMRANPC>
In-Reply-To: <01a301c2582c$754dbf30$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oTFW-0006qo-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 20:12, Imran Badr wrote:
> But my question here still begging an answer: What would be the portable way
> to calculate kernel logical address of that user buffer?

Could you please post your code for doing the kmalloc and mmap?

-- 
Daniel
