Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTGBUug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTGBUug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:50:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29077
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264488AbTGBUuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:50:35 -0400
Subject: Re: [PATCH] fix 2.4.22-pre broken x86 math-emu
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030702162225.GA10974@codepoet.org>
References: <20030702030013.GA3405@codepoet.org>
	 <Pine.LNX.4.55L.0307021051420.11896@freak.distro.conectiva>
	 <20030702162225.GA10974@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057179710.20319.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jul 2003 22:01:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-02 at 17:22, Erik Andersen wrote:
> On Wed Jul 02, 2003 at 10:52:02AM -0300, Marcelo Tosatti wrote:
> > 
> > 
> > I'm no GCC nor asm guru, so, Alan?
> 
> This does not change even one asm instruction.  This merely
> changes the quoting and semicolons...

Erik is right - I sent you a buggy fix, then a correct fix, but
his cleanup is nicer


