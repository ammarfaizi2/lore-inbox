Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSJ3O5i>; Wed, 30 Oct 2002 09:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSJ3O5i>; Wed, 30 Oct 2002 09:57:38 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:64642 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264697AbSJ3O5f>; Wed, 30 Oct 2002 09:57:35 -0500
Subject: Re: Running linux-2.4.20-rc1 on Dell Dimension 4550
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Orion Poplawski <orion@colorado-research.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       req@earth.colorado-research.com
In-Reply-To: <200210292353.g9TNrq514597@earth.colorado-research.com>
References: <200210292353.g9TNrq514597@earth.colorado-research.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Oct 2002 15:23:30 +0000
Message-Id: <1035991410.5140.76.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-29 at 23:53, Orion Poplawski wrote:
> Thought I'd post some information about what I'm seeing running RH7.3 with 
> kernel 2.4.20-rc1 on a brand new Dell Dimension 4550.  Currently there are 
> two problems with the machine:

The -ac tree may get your sound working. Please let me know either way
(you can just pull the i810_audio and ac97 patches from the tree). The
onboard video probably needs the 4.2 Xservers from 8.0 and may even need
the upcoming 4.3 XFree86 release (or try CVS XFree86 if you are bold)

Alan

