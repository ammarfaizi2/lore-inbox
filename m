Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317876AbSGROMN>; Thu, 18 Jul 2002 10:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318063AbSGROMN>; Thu, 18 Jul 2002 10:12:13 -0400
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:61851 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S317876AbSGROMM>; Thu, 18 Jul 2002 10:12:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd.schubert@tc.pci.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: stale nfs errors on proc
Date: Thu, 18 Jul 2002 16:15:11 +0200
User-Agent: KMail/1.4.2
References: <200207181613.17319.bernd.schubert@tc.pci.uni-heidelberg.de>
In-Reply-To: <200207181613.17319.bernd.schubert@tc.pci.uni-heidelberg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207181615.11745.bernd.schubert@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 16:13, Bernd Schubert wrote:
> Hi,
>
> sometimes we get stale nfs errors with proc files. Mostly this happens with
> sshd (remote ssh login is not possible in this case), on trying to kill the
> sshd server by killall -15 sshd, we get something like this (I have
> forgotten the exact syntax): stale nfs error on /proc/nn/EXE
>
> A killall -9 sshd works fine.
>
>
> Best Regards,
>
> Bernd

Oh, I forgot, happens with 2.4.{17,18} kernel version.
