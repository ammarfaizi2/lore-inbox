Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318797AbSHBL5c>; Fri, 2 Aug 2002 07:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318803AbSHBL5c>; Fri, 2 Aug 2002 07:57:32 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:31990 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318797AbSHBL5a>; Fri, 2 Aug 2002 07:57:30 -0400
Subject: Re: Console scrolling in kernel 2.4.xx
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Knigge <Michael.Knigge@set-software.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020802.11011405@knigge.local.net>
References: <20020802.11011405@knigge.local.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 14:17:46 +0100
Message-Id: <1028294266.18317.67.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 12:01, Michael Knigge wrote:
> With Linux 2.2.xxx there are no problems, but with Kernels 2.4.xx 
> scrolling doesn't work :-((((

That sounds like you may have very old VSA1 firmware in the BIOS. Does
it behave if you enable the VESA console and boot with a vesa bios
framebuffer set ?


