Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbTJUWre (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTJUWre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:47:34 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:22409 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263308AbTJUWrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:47:33 -0400
Date: Tue, 21 Oct 2003 17:47:26 -0500 (CDT)
From: Pat Gefre <pfg@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix console driver
In-Reply-To: <20031021150027.48ddcd1e.akpm@osdl.org>
Message-ID: <Pine.SGI.3.96.1031021174117.240932O-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003, Andrew Morton wrote:

+ Patrick Gefre <pfg@sgi.com> wrote:
+ >
+ > 2.6 Altix serial console driver add
+ 
+ Were all the points which Christoph raised considered?
+ 
+ http://www.ussg.iu.edu/hypermail/linux/kernel/0309.2/0465.html
+ 

I addressed as many as I could - almost all of them I think. FWIW this
driver is very close to the one I sent for 2.4. I would like to,
eventually, convert the code to use the serial_core calls....

-- Pat

