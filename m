Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277282AbRKHR75>; Thu, 8 Nov 2001 12:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277068AbRKHRz5>; Thu, 8 Nov 2001 12:55:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46863 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277230AbRKHRzf>; Thu, 8 Nov 2001 12:55:35 -0500
Subject: Re: Bug Report: Dereferencing a bad pointer
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Thu, 8 Nov 2001 18:02:44 +0000 (GMT)
Cc: chandler@grammatech.com (David Chandler), linux-kernel@vger.kernel.org
In-Reply-To: <20011108112720.C24378@redhat.com> from "Benjamin LaHaise" at Nov 08, 2001 11:27:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161tVk-0000Cc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Nov 08, 2001 at 10:29:19AM -0500, David Chandler wrote:
> > I get the same result with gcc 3.0.1 and gcc 2.96 (and yes, the relevant
> > generated code differs slightly).  I have tried Linus's official 2.4.13+UML
> > on UML, but I've not tried 2.4.13-ac8.
> 
> Perhaps you should try -ac?

If you do then use ac7 for x86
