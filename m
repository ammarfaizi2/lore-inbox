Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVCKQjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVCKQjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVCKQjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:39:15 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10669
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261188AbVCKQjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:39:12 -0500
Subject: Re: binary drivers and development
From: Benedikt Spranger <b.spranger@linutronix.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050311103912.GB16590@home.fluff.org>
References: <423075B7.5080004@comcast.net> <423082BF.6060007@comcast.net>
	 <Pine.LNX.4.61.0503101744170.16741@chimarrao.boston.redhat.com>
	 <20050311103912.GB16590@home.fluff.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 17:39:05 +0100
Message-Id: <1110559146.5828.116.camel@atlas.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> On Thu, Mar 10, 2005 at 05:45:22PM -0500, Rik van Riel wrote:
> > No, it wouldn't.  I can use a source code driver on x86,
> > x86-64 and PPC64 systems, but a binary driver is only
> > usable on the architecture it was compiled for.
> 
> Add to that the flavours of ARM and the number of
> bootloaders that are out there.

you need visions:
let us define the 1k buswith MMIX aware VM driver model...

Bene



