Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbTHULwm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 07:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbTHULwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 07:52:42 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:59150 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262630AbTHULwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 07:52:41 -0400
Message-Id: <200308211159.h7LBxOhW002506@ccure.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting VM feature? 
In-Reply-To: Your message of "20 Aug 2003 19:24:25 PDT."
             <bi1agp$40b$1@cesium.transmeta.com> 
References: <147bb3140e7a.140e7a147bb3@rdc-kc.rr.com> <20030815200020.GM1027@matchmail.com> <20030815211937.GA20208@mail.jlokier.co.uk>  <bi1agp$40b$1@cesium.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Aug 2003 07:59:24 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com said:
> It *would* be nice with a way to be able to say to the kernel "you may
> discard this but if so I want SIGSEGV", for things like LPSM and the
> like. 

Yeah, UML could put this to good use, as well...

				Jeff

