Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271412AbTHMHTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 03:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271420AbTHMHTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 03:19:25 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:1036 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S271412AbTHMHTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 03:19:24 -0400
Message-Id: <200308130718.h7D7ISd20208@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: William Lee Irwin III <wli@holomorphy.com>,
       Nufarul Alb <nufarul.alb@home.ro>
Subject: Re: multibooting the linux kernel
Date: Wed, 13 Aug 2003 10:18:27 +0300
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <3F396C04.90608@home.ro> <20030813002944.GJ32488@holomorphy.com>
In-Reply-To: <20030813002944.GJ32488@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 August 2003 03:29, William Lee Irwin III wrote:
> On Wed, Aug 13, 2003 at 01:36:52AM +0300, Nufarul Alb wrote:
> > There is a patch for the kernel that make it able to preload modules 
> > before the acutal booting.
> > I wonder if this feature will be included in the official linux kernel.
> > The patch can be found at 
> > http://home.t-online.de/home/ChristianK./patches/ .
> > thanks;-)
> 
> No idea. It might help if someone (this means you) started maintaining
> it and sending it in. =)

Do we want to stuff every imaginable early userspace stuff into kernel?

<sarcasm>
I vote for iwconfig and cipe tunnels, because I mount my root filesystem
over them!
</sarcasm>
--
vda
