Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTENNaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTENNaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:30:10 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:61114 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S262185AbTENNaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:30:08 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Nicolae_Popovici@mksinst.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 freeze problem.
Date: Wed, 14 May 2003 15:42:38 +0200
User-Agent: KMail/1.5.1
References: <OF699B450E.9BF05B14-ONC1256D26.00471201-C1256D26.00482FE7@mksinternal.com>
In-Reply-To: <OF699B450E.9BF05B14-ONC1256D26.00471201-C1256D26.00482FE7@mksinternal.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305141542.38873.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 May 2003 14:58, Nicolae_Popovici@mksinst.com wrote:
> Hi  guys,
>
>  Here are the facts.
> I have a small user program and the latest 2.4.20 stable kernel.
> It is running on a board from IEI ( Wafer-5823 ) with a Cyrix 300 CPU.
>  What happens is that after 2 hours of running this user program the
> computer
> freezes. I have the linux crash dump compiled inside the kernel and
> activated
> along with the magic sysrq key. Nothing works. I get only some messages
> inside

Hi,

perhaps a hardware/temperature problem. How about measuring the temperature 
with lmsensors ?

Bernd

