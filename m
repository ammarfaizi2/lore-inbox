Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311023AbSCLNCj>; Tue, 12 Mar 2002 08:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311171AbSCLNC3>; Tue, 12 Mar 2002 08:02:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:34702 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S311023AbSCLNCT>;
	Tue, 12 Mar 2002 08:02:19 -0500
Date: Tue, 12 Mar 2002 14:01:28 +0100 (CET)
From: Karsten Weiss <knweiss@gmx.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0203121351070.3320-100000@addx.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Marcelo Tosatti wrote:

> Here goes -pre3, with the new IDE code. It has been stable enough time in

I´m surprised that there are no descriptions for the following
config options (after months of fights for inclusion of this
patch):

CONFIG_IDEDISK_STROKE
CONFIG_IDE_TASK_IOCTL
CONFIG_BLK_DEV_IDEDMA_FORCED
CONFIG_IDEDMA_ONLYDISK
CONFIG_BLK_DEV_ELEVATOR_NOOP

Or did you simply forget to merge them?

bye,
  Karsten

-- 
Karsten Weiss - http://www.machineroom.de/knweiss

