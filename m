Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbSKGELw>; Wed, 6 Nov 2002 23:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266337AbSKGELw>; Wed, 6 Nov 2002 23:11:52 -0500
Received: from signup.localnet.com ([207.251.201.46]:7126 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S266323AbSKGELv>;
	Wed, 6 Nov 2002 23:11:51 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: 2.5 bk, input driver and dell i8100 nib+pad
References: <m3n0omk97i.fsf@lugabout.jhcloos.org>
	<11033.1036602261@passion.cambridge.redhat.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <11033.1036602261@passion.cambridge.redhat.com>
Date: 06 Nov 2002 23:18:13 -0500
Message-ID: <m3k7jqj9mi.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Woodhouse <dwmw2@infradead.org> writes:

>> Trying out 2.5, I've got only a partially working mouse.  The usb
>> mouse is fully functional, as are both sets of buttons on the
>> notebook.  The mouse pad works, but the nib is ignored.

David> http://lists.insecure.org/lists/linux-kernel/2002/Oct/7774.html

The patch in the referenced post did not fix this for me in 2.5 bk
current.  The nib continued to do nothing.

-JimC

