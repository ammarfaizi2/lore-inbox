Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbSKGKFM>; Thu, 7 Nov 2002 05:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbSKGKFM>; Thu, 7 Nov 2002 05:05:12 -0500
Received: from signup.localnet.com ([207.251.201.46]:49563 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S266435AbSKGKFL>;
	Thu, 7 Nov 2002 05:05:11 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: 2.5 bk, input driver and dell i8100 nib+pad
References: <m3k7jqj9mi.fsf@lugabout.jhcloos.org>
	<m3n0omk97i.fsf@lugabout.jhcloos.org>
	<11033.1036602261@passion.cambridge.redhat.com>
	<5339.1036653369@passion.cambridge.redhat.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <5339.1036653369@passion.cambridge.redhat.com>
Date: 07 Nov 2002 05:11:04 -0500
Message-ID: <m3el9xk7uv.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Woodhouse <dwmw2@infradead.org> writes:

>> The patch in the referenced post did not fix this for me in 2.5 bk
>> current.  The nib continued to do nothing.

David> You need to reboot or suspend and resume, Just unloading and
David> reloading the psmouse module isn't sufficient.

Of course; I even incremented my EXTRAVERSION for the new kernel, and
the import and compile was done in a fresh clone....

-JimC



