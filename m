Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbTEJO5f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 10:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTEJO5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 10:57:34 -0400
Received: from pop.gmx.de ([213.165.65.60]:59586 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264332AbTEJO5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 10:57:34 -0400
Date: Sat, 10 May 2003 17:07:51 +0200
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <1052575167.16165.0.camel@dhcp22.swansea.linux.org.uk>
References: <1405.1052575075@www9.gmx.net>
	<1052575167.16165.0.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <S264332AbTEJO5e/20030510145734Z+7011@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 May 2003 14:59:31 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sad, 2003-05-10 at 14:57, Tuncer M zayamut Ayaz wrote:
> > description of the strange sound: 
> >   - high tone 
> >   - permanent 
> >   - happens before loading ALSA modules 
> 
> What happens if you mute the microphone and line in ?

how to do that prior to booting up the kernel?
if I should do it later (after module loading, maybe on
amixer init) I'd have to consult amixer manuals
to see how that works first...
