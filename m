Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264909AbUEYPPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbUEYPPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 11:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUEYPPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 11:15:43 -0400
Received: from imap.gmx.net ([213.165.64.20]:44462 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264909AbUEYPPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 11:15:41 -0400
X-Authenticated: #1269185
From: Manuel Kasten <kasten.m@gmx.de>
To: Bruno Ducrot <poup@poupinou.org>, linux-kernel@vger.kernel.org
Subject: Re: [speedste-centrino] couldn't enable Enhanced SpeedStep
Date: Tue, 25 May 2004 17:15:40 +0200
User-Agent: KMail/1.6.2
References: <200405231126.11815.kasten.m@gmx.de> <20040525145259.GA10063@poupinou.org>
In-Reply-To: <20040525145259.GA10063@poupinou.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405251715.40529.kasten.m@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Could you please try with CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
> enabled?  Sometimes, the BIOS would require that the OS take
> ownership of the performance stuff..

I have done that already. The only change is, that he won't report 
"found: Intel(R) Pentium(R) M processor 1500MHz". The line with 
"couldn't enable Enhanced SpeedStep" remains unchanged.

MfG
	Manuel Kasten
