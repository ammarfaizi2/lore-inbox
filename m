Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUJTO4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUJTO4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUJTO4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:56:37 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29968 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261474AbUJTO4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:56:18 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: X does not start. vm86old returns ENOSYS??
Date: Wed, 20 Oct 2004 17:56:06 +0300
User-Agent: KMail/1.5.4
Cc: Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org
References: <200410201653.33233.vda@port.imtp.ilyichevsk.odessa.ua> <417672B3.4030801@didntduck.org>
In-Reply-To: <417672B3.4030801@didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410201756.06694.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 17:14, Brian Gerst wrote:
> Denis Vlasenko wrote:
> > How can vm86old from X return ENOSYS??
> > I have no more ideas how to proceed from here.
> 
> Are you trying to run a 32-bit X server on a 64-bit kernel?  x86-64 does 
> not support vm86 mode.

x86-64 with i845 chipset?! You must be kidding.
--
vda

