Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317522AbSGVOqL>; Mon, 22 Jul 2002 10:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317537AbSGVOqL>; Mon, 22 Jul 2002 10:46:11 -0400
Received: from pcp809445pcs.nrockv01.md.comcast.net ([68.49.82.129]:55941 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S317522AbSGVOqL>;
	Mon, 22 Jul 2002 10:46:11 -0400
Date: Mon, 22 Jul 2002 10:49:19 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon XP 1800+ segemntation fault
Message-ID: <20020722104919.A3472@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20020722133259.A1226@acc69-67.acn.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020722133259.A1226@acc69-67.acn.pl>; from karol_olechowski@acn.waw.pl on Mon, Jul 22, 2002 at 01:32:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 01:32:59PM +0000, Karol Olechowskii wrote:
> Hello 
> 
> Few days ago I've bought new processor Athlon XP 1800+ to my computer
> (MSI K7D Master with 256 MB PC2100 DDR).Before that I've got Athlon ThunderBird
> 900 processor and everything had been working well till I change to the new one.
> Now for every few minutes I've got segmetation fault or immediate system reboot.
> Could anyone tell me what's goin' on?

mem=nopentium on the command line seems to have a stabilizing effect.
Of course, as alan says, real debugging is impossible.

  OG, with the same problem
