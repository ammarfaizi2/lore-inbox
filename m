Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272459AbTHEGoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 02:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272460AbTHEGof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 02:44:35 -0400
Received: from holomorphy.com ([66.224.33.161]:35458 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272459AbTHEGod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 02:44:33 -0400
Date: Mon, 4 Aug 2003 23:45:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: .config in bzImage ?
Message-ID: <20030805064528.GR32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
	linux-kernel@vger.kernel.org
References: <20030802192957.GC32488@holomorphy.com> <E19j2sd-0003VB-00@calista.inka.de> <20030802202803.GD32488@holomorphy.com> <200308050632.h756W5j17568@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308050632.h756W5j17568@Port.imtp.ilyichevsk.odessa.ua>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 August 2003 23:28, William Lee Irwin III wrote:
>> Which requires having some way to associate the running kernel to those
>> files.

On Tue, Aug 05, 2003 at 09:41:35AM +0300, Denis Vlasenko wrote:
> bash-2.03# ls -l /boot
> drwxr-xr-x    2 root     root         1024 Jan 28  2003 2.4.20
> drwxr-xr-x    2 root     root         1024 Nov  2  2002 2.4.20-pre11csum_t
> drwxr-xr-x    2 root     root         1024 Oct 30  2002 2.4.20-pre11csumtest
> drwxr-xr-x    2 root     root         1024 Jul 17 08:10 2.4.21
> drwxr-xr-x    2 root     root         1024 Jul 17 15:15 2.4.21-ep

Insufficient. That's what I do most of the time anyway; when I got
burned it was with a batch of kernels I'd built simultaneously.


-- wli
