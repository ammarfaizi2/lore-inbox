Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275709AbRJQLCj>; Wed, 17 Oct 2001 07:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275716AbRJQLC3>; Wed, 17 Oct 2001 07:02:29 -0400
Received: from [202.97.230.81] ([202.97.230.81]:48055 "HELO 0451.com")
	by vger.kernel.org with SMTP id <S275709AbRJQLCX>;
	Wed, 17 Oct 2001 07:02:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Liu Tao <debian@0451.com>
Reply-To: debian@0451.com
Organization: Harbin Engineering University 98-612 Class
To: linux-kernel@vger.kernel.org
Subject: Re: VM
Date: Wed, 17 Oct 2001 19:08:01 +0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <DD0DC14935B1D211981A00105A1B28DB033ED3D8@NL-ASD-EXCH-1>
In-Reply-To: <DD0DC14935B1D211981A00105A1B28DB033ED3D8@NL-ASD-EXCH-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011017110224Z275709-17408+1539@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested "mtest01 -p 200 -w" on both 2.4.12-ac3 and 2.4.13pre3aa1,
in single mode both killed mtest01, but in kde 2.4.13pre3aa1 can't kill
mtest01 after a long wait, and I have to reset.

I have 128M ram, 500M swap on IDE disk, Celeron 433 cpu.

Regards
Liu Tao
