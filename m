Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266077AbTLISxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbTLISxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:53:33 -0500
Received: from main.gmane.org ([80.91.224.249]:45536 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266067AbTLISx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:53:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 19:53:26 +0100
Message-ID: <yw1xvfop257d.fsf@kth.se>
References: <1070963757.869.86.camel@nomade> <Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
 <20031209183001.GA9496@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:9/Tj/uj7nwlMCtp7MQdR7YOaMlg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Tue, Dec 09, 2003 at 02:03:42PM +0100, Maciej Zenczykowski wrote:
>
>> - just because a device is present in the system doesn't mean that
>> it's kernel modules are loaded
>
> No, but one could argue that it should :)

One could equally well argue that it need not.

>> - for example my floppy is always present in the system, but I access
>> it like once a month or so
>
> Then, when you want to access it, a simple 'modprobe floppy' would work
> for you, right?

Only if you are root.

-- 
Måns Rullgård
mru@kth.se

