Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTGALsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 07:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTGALsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 07:48:40 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37647 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262273AbTGALsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 07:48:37 -0400
Subject: Re: [RFC/PATCH] Touchpads in absolute mode (synaptics) and mousedev
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200307010303.53405.dtor_core@ameritech.net>
References: <200307010303.53405.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1057060977.603.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 01 Jul 2003 14:02:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 10:03, Dmitry Torokhov wrote:

> - touchpads are not precise; when I take my finger off touchpad and then
>   touch it again somewhere else I do not expect my cursor jump anywhere,
>   I only expect cursor to move when I move my finger while pressing 
>   touchpad.

Uhmmm... Maybe I'm losing something here, but my NEC Chrom@'s
ALPS/GlidePoint touchpad doesn't cause the mouse cursor to jump/move
when I lift off my finger from it and then touch it again elsewhere. The
mouse cursor moves only when I drag my finger over the touchpad surface.

