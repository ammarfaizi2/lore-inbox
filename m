Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312450AbSDJKtb>; Wed, 10 Apr 2002 06:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312455AbSDJKta>; Wed, 10 Apr 2002 06:49:30 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:14484 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S312450AbSDJKta>; Wed, 10 Apr 2002 06:49:30 -0400
Message-ID: <3CB418B7.BB5CFEB9@delusion.de>
Date: Wed, 10 Apr 2002 12:49:27 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.8-pre3 linking error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

2.5.8-pre3 fails to link here:

init/main.o: In function `start_kernel':
init/main.o(.text.init+0x681): undefined reference to `setup_per_cpu_areas'

-Udo.
