Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSHGM2f>; Wed, 7 Aug 2002 08:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317338AbSHGM2f>; Wed, 7 Aug 2002 08:28:35 -0400
Received: from theorie3.physik.uni-erlangen.de ([131.188.166.130]:46857 "EHLO
	theorie3.physik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317331AbSHGM2f>; Wed, 7 Aug 2002 08:28:35 -0400
Date: Wed, 7 Aug 2002 14:32:09 +0200
From: Norbert Nemec <nobbi@theorie3.physik.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: Problems with various networking-cards (tulip,3c59x,etc.) on 2.4.19-smp machine
Message-ID: <20020807122953.GA580@theorie3.physik.uni-erlangen.de>
Reply-To: Norbert Nemec <nobbi@theorie3.physik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have been trying to update a SMP machine to kernel 2.4, but I stubled over
the same problem over and over again:

With SMP enabled, the network card does neither send nor receive any data. There are
no error messages, but the card behaves just as if the cable was physically disconnected.

I have tried the de4x5 and the tulip driver with no success, and a 3c59x-card
with just the same problem.

The problem occurred on two identical dual-PPro machines, so hardware problems
should be excluded. Kernel 2.2.13 does work without problems. With SMP disabled,
the problem disappears. I have tried 2.4.18 as well as 2.4.19

Could anyone help me to find the correct person to contact about it?

Thanks,
Nobbi

PS: Please CC me, I've not subscribed.

-- 
-- _____________________________________Norbert "Nobbi" Nemec
-- Hindenburgstr. 44   ...   D-91054 Erlangen   ...   Germany
-- eMail: <Norbert@Nemec-online.de>  Tel: +49-(0)-9131-204180
