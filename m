Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292869AbSBVORE>; Fri, 22 Feb 2002 09:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292871AbSBVOQy>; Fri, 22 Feb 2002 09:16:54 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:36337 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S292869AbSBVOQk>; Fri, 22 Feb 2002 09:16:40 -0500
Message-ID: <3C7652C7.96D0B730@redhat.com>
Date: Fri, 22 Feb 2002 14:16:39 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <3C764B7C.2000609@evision-ventures.com>; from dalecki@evision-ventures.com on Fri Feb 22 2002 at 02:45:32PM +0100 <20020222150323.A5530@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> I think it'd be even better if the chipset drivers did the probing
> themselves, and once they find the IDE device, they can register it with
> the IDE core. Same as all the other subsystem do this.

Please send me your scsi subsystem then ;)
