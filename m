Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266389AbSKGHJc>; Thu, 7 Nov 2002 02:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266390AbSKGHJb>; Thu, 7 Nov 2002 02:09:31 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:31485 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266389AbSKGHJb>; Thu, 7 Nov 2002 02:09:31 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <m3k7jqj9mi.fsf@lugabout.jhcloos.org> 
References: <m3k7jqj9mi.fsf@lugabout.jhcloos.org>  <m3n0omk97i.fsf@lugabout.jhcloos.org> <11033.1036602261@passion.cambridge.redhat.com> 
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: 2.5 bk, input driver and dell i8100 nib+pad 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 07:16:09 +0000
Message-ID: <5339.1036653369@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cloos@jhcloos.com said:
>  The patch in the referenced post did not fix this for me in 2.5 bk
> current.  The nib continued to do nothing. 

You need to reboot or suspend and resume, Just unloading and reloading the 
psmouse module isn't sufficient.

--
dwmw2


