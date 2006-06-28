Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423199AbWF1H3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423199AbWF1H3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423204AbWF1H3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:29:37 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:6838 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1423199AbWF1H3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:29:35 -0400
Date: Wed, 28 Jun 2006 09:29:32 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: broken auto-repeat on PS/2 keyboard
Message-ID: <20060628092932.18b07b43@localhost>
In-Reply-To: <d120d5000606271034l693567a3r23d892204d5fd3f7@mail.gmail.com>
References: <20060627162733.551f844f@localhost>
	<d120d5000606271034l693567a3r23d892204d5fd3f7@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 13:34:26 -0400
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> Paolo,
> 
> Thank you for identifying the problem commit. Please try the attached
> patch, it should fix the problem.

It works :)

-- 
	Paolo Ornati
	Linux 2.6.17-ga39727f2-dirty on x86_64
