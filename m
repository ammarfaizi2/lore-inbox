Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSLQJx1>; Tue, 17 Dec 2002 04:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbSLQJx1>; Tue, 17 Dec 2002 04:53:27 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:16582 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S264863AbSLQJx0>; Tue, 17 Dec 2002 04:53:26 -0500
Date: Tue, 17 Dec 2002 22:58:25 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: "O.Sezer" <sezero@superonline.com>, linux-kernel@vger.kernel.org
Subject: Re: rmap and nvidia?
Message-ID: <3250000.1040119105@localhost.localdomain>
In-Reply-To: <3DFE522A.6010803@superonline.com>
References: <3DFE522A.6010803@superonline.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bit calling pte_unmap in nv-linux.h is the only difference from the 
current minion.de patch, but it works, doesn't oops any more, nor does it 
leak memory any more :-)

Great!  X on 2.5 on my laptop!

Andrew

--On Tuesday, December 17, 2002 00:22:34 +0200 "O.Sezer" 
<sezero@superonline.com> wrote:

> Is this patch correct in any way?
> (Ripped out of the 2.5 patch and modified some).
>
> Thanks.
>


