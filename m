Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbSKVIpb>; Fri, 22 Nov 2002 03:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267011AbSKVIpb>; Fri, 22 Nov 2002 03:45:31 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:51729 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267001AbSKVIpa>; Fri, 22 Nov 2002 03:45:30 -0500
Message-Id: <200211220846.gAM8kPp30627@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Roland Schwarz" <webmaster@rolandschwarz.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Interrupts problem with 3com network cards on dual-cpu systems ?
Date: Fri, 22 Nov 2002 11:37:14 -0200
X-Mailer: KMail [version 1.3.2]
References: <NNEIJAEFFFIEBKPOMOJFAEKDDLAA.webmaster@rolandschwarz.net>
In-Reply-To: <NNEIJAEFFFIEBKPOMOJFAEKDDLAA.webmaster@rolandschwarz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 November 2002 20:51, Roland Schwarz wrote:
> Hi kernel-hackers out there ! :-)
>
>
> Maybe someone of you can help me with a problem I have here with
> three computers and Linux. Okay, three computers, all of them are
> DualCPU systems.
>
> 1. P2-300 dual, 256 megs of ram
>
> 2. P2-400 dual, 512 megs ram
>
> 3. P3-800 dual . 1 GB ram .
>
> All computers use 3com network cards ( 3C95x ) , number one has two,
> this is my gateway//firewall computer. As Distribution I currently
> use Suse Linux 8.1, kernel version 2.4.19-64 GB. Firewall is
> iptables.

Care to provide lspci, kernel config, boot and module parameters?
Did you try latest 2.4?
--
vda
