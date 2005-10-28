Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVJ1Pp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVJ1Pp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 11:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVJ1Pp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 11:45:57 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:47250
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1030216AbVJ1Pp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 11:45:57 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Date: Fri, 28 Oct 2005 11:45:54 -0400
Message-Id: <20051028154109.M9269@linuxwireless.org>
In-Reply-To: <m1mzktbqxt.fsf@ebiederm.dsl.xmission.com>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade> <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade> <20051027211203.M33358@linuxwireless.org> <m1mzktbqxt.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005 09:29:34 -0600, Eric W. Biederman wrote
> "Alejandro Bonilla" <abonilla@linuxwireless.org> writes:
> 
> >> so there is no way to give me back the "lost" memory. Is it possible
> >> that another motherboard might help?
> >
> > AFAIK, No. AMD and Intel will always do the same thing until we all move to
> > real IA64.
> 
> IA64 inherits this part of the architecture from x86, so no magic 
> fix. This is a fundamentally a chipset limitation, not an 
> architectural bug.

Probably, but if they add a function to support this, then is a Fix, else it
would have been there all the time.

> 
> rev-E amd64 cpus from AMD all have memory hoisting support,
> as do all server chipsets from Intel for the last several years.

Not according to the link I provided since we started the conversation. But
they have done tweaks to start "supporting" all this memory.

> 
> To avoid this you just need a good chipset and a good BIOS implementation.
> Any recent server board should be fine.  Hopefully the desktop boards
> will catch up soon.

I doubt it, Intel is slowly moving to 64bit so applications and OS can catch
up in the future to leave 32bit behind. (Probably)

Anyway, I think Marcel got most of he's doubt answered.

.Alejandro

> 
> Eric


