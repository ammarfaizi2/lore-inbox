Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285154AbRLFQST>; Thu, 6 Dec 2001 11:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285150AbRLFQR6>; Thu, 6 Dec 2001 11:17:58 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:297 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284933AbRLFQRx>; Thu, 6 Dec 2001 11:17:53 -0500
Message-ID: <3C0F9A2F.5D019244@redhat.com>
Date: Thu, 06 Dec 2001 16:17:51 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg Hennessy <gsh@cox.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <20011206110713.A8404@cox.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Hennessy wrote:
> 
> I recently installed a  both a Dell dual cpu 2500 server (dual 1.6 ghz
> ia32 chips) and a dell 7150 (dual IA64 chips). My users complained
> that the disk io speed on the itanium seemed very slow, even though
> both servers have a megaraid controller with seagate cheetah
> disks. Bonnie also shows the ia64 machine having worse throughput than
> the ia32 machine.

How much RAM do you have ?
