Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271419AbTG2MxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271705AbTG2MxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:53:19 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:47337 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S271419AbTG2MxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:53:18 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Wakko Warner <wakko@animx.eu.org>
Date: Tue, 29 Jul 2003 14:52:45 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb and 2.6.0-test2
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <89C0F2D0B58@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 03 at 8:53, Wakko Warner wrote:
> > 
> > Yes, it supports Millennium1 too. Are you sure that you built fbcon
> > support into the kernel? And that you have only one fbdev, matroxfb?
> 
> Yes.  This caused a permenant black screen.  fbset did not give me anything
> usable.  Monitor did not go into powersave.

I assume that machine is otherwise OK. Can you capture 'dmesg' from
such boot and post them?
                                            Petr
                                            

