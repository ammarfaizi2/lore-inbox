Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266399AbSKGHeo>; Thu, 7 Nov 2002 02:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266400AbSKGHeo>; Thu, 7 Nov 2002 02:34:44 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:44541 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266399AbSKGHeo>; Thu, 7 Nov 2002 02:34:44 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3DCA166C.7080009@snapgear.com> 
References: <3DCA166C.7080009@snapgear.com>  <8025.1036600362@passion.cambridge.redhat.com> 
To: gerg@snapgear.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Console init revamp. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 07:41:19 +0000
Message-ID: <6047.1036654879@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gerg@snapgear.com said:
>  That has been on my todo list for a while :-)
> I should have them all cleaned up into a single vmlinux.lds.S file by
> end of today or tomorrow.

You know, the rest of the vmlinux.lds.S files could also do with a little 
#include loving, while you're at it... :)

--
dwmw2


