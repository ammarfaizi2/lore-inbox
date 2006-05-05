Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWEEHXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWEEHXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 03:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWEEHXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 03:23:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59881 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750750AbWEEHXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 03:23:09 -0400
Subject: Re: Buffering Models
From: Arjan van de Ven <arjan@infradead.org>
To: Deven Balani <devenbalani@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7a37e95e0605050020x3b355e6cqdc6a59befb35d8d3@mail.gmail.com>
References: <7a37e95e0605050020x3b355e6cqdc6a59befb35d8d3@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 05 May 2006 09:23:06 +0200
Message-Id: <1146813787.2891.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-05 at 12:50 +0530, Deven Balani wrote:
> Hi All
> 
> I am working on Real-time streaming Applications, which is using
> various Buffer Models, Can any one help in understanding the exact
> _scenario_ to use these flow control mechanisms,
> 
> 1) Circular Buffer.
> 2) Low Water Mark Mechanism with DMA.
> 3) Ping Pong Handshake. (or) Double Buffering.


the homework helpline is --> that way ;-)


