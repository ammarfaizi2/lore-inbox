Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315990AbSENSvy>; Tue, 14 May 2002 14:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315991AbSENSvx>; Tue, 14 May 2002 14:51:53 -0400
Received: from daimi.au.dk ([130.225.16.1]:852 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315990AbSENSvw>;
	Tue, 14 May 2002 14:51:52 -0400
Message-ID: <3CE15CC4.3F2BBEB5@daimi.au.dk>
Date: Tue, 14 May 2002 20:51:48 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
In-Reply-To: <elladan@eskimo.com> <200205131709.g4DH9Fjv006328@pincoya.inf.utfsm.cl> <20020513105250.A30395@eskimo.com> <20020513185723.A2657@infradead.org> <20020514092254.A2581@eskimo.com> <20020514125536.B22935@mark.mielke.cc> <20020514104753.A3070@eskimo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elladan wrote:
> 
> it's ext[23] only and not really very useful.

I actually find it very useful, but I cannot argue against the
fact that it is an ext[23] specific feature.

I might like to implement a similar feature in a filesystem
independend way.

The documentation about quotas says it is also ext2 specific.
Is that still true? And has anybody BTW verified that the
quota system doesn't suffer from the same problems?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
