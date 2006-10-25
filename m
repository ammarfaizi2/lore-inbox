Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWJYNw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWJYNw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 09:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWJYNw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 09:52:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:14485 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030229AbWJYNw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 09:52:26 -0400
Subject: Re: What about make mergeconfig ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <9a8748490610250301k6d10b168x37a4d667c4016601@mail.gmail.com>
References: <1161755164.22582.60.camel@localhost.localdomain>
	 <9a8748490610250301k6d10b168x37a4d667c4016601@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 23:52:17 +1000
Message-Id: <1161784337.22582.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmm, wouldn't you only have to build that config once and then in the
> future just use "make oldconfig" to keep it up-to-date with newer
> kernels ?

Well, it's handy to be able to pick up a fresh new upstream tree and
build a config for pmac+pseries for example.

Ben.


