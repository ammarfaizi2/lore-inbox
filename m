Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316826AbSGROH1>; Thu, 18 Jul 2002 10:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316832AbSGROH1>; Thu, 18 Jul 2002 10:07:27 -0400
Received: from jalon.able.es ([212.97.163.2]:41385 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316826AbSGROH0>;
	Thu, 18 Jul 2002 10:07:26 -0400
Date: Thu, 18 Jul 2002 16:10:20 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: devik <devik@cdi.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 is not SMP friendly
Message-ID: <20020718141020.GA1785@werewolf.able.es>
References: <Pine.LNX.4.33.0207181244550.535-100000@devix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0207181244550.535-100000@devix>; from devik@cdi.cz on Thu, Jul 18, 2002 at 12:51:46 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.18 devik wrote:
>Hello,
>
>I someone here running 2.4.18 on PII SMP successfully ?
>My SMP box was happily running 2.4.3 but after upgrade
>to 2.4.18 I got 3 oopses in 4 days.

Solid as a rock on dual PII@400. Anso on a Dual Xeon and on a bunch of
dual PIII boxes. Even I run jam kernels built with gcc3.1.1, but when
I get into trouble 2.4.18 is there.

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc2-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
