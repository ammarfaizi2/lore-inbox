Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbUAZWDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265321AbUAZWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:03:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:15073 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265259AbUAZWDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:03:03 -0500
Subject: Re: [PATCH] Big powermac update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040126152921.GF15271@stop.crashing.org>
References: <1074825487.976.183.camel@gaston>
	 <20040123175443.GA15271@stop.crashing.org> <1074905912.834.43.camel@gaston>
	 <20040125185549.GD15271@stop.crashing.org> <1075075758.848.34.camel@gaston>
	 <20040126152921.GF15271@stop.crashing.org>
Content-Type: text/plain
Message-Id: <1075154485.6296.93.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 09:01:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> But that's how it starts out... :)  If it turns out that you need to add
> more regs in later, can you please move all of the POWER4/GPUL
> definitions into their own file?  Thanks.

Will do if it's really necessary. At this point it is really not :)

Ben.


