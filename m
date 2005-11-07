Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVKGNyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVKGNyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 08:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVKGNyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 08:54:16 -0500
Received: from [81.2.110.250] ([81.2.110.250]:33425 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932486AbVKGNyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 08:54:16 -0500
Subject: Re: 3D video card recommendations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1131367371.14381.91.camel@localhost.localdomain>
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <1131349343.2858.11.camel@laptopd505.fenrus.org>
	 <1131367371.14381.91.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Nov 2005 14:24:21 +0000
Message-Id: <1131373462.11265.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-07 at 07:42 -0500, Steven Rostedt wrote:
> Are there good 3D cards that don't depend on a proprietary module, that
> can run on a AMD64 board?  That was pretty much my questing to begin
> with :)

Some of the radeons - R3xx is pretty close to usable R2xx works well.
Support for running 32bit hardware accelerated apps on 64bit kernel
recently went in.

