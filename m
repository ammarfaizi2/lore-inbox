Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbTJXRwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 13:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbTJXRwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 13:52:41 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:33547 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262432AbTJXRwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 13:52:40 -0400
Date: Fri, 24 Oct 2003 18:52:39 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: "Catani, Antonio" <Antonio.Catani@seceti.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
In-Reply-To: <9E8BE1B970A998468D92381A112AA3EA0140E0@srvrm001.roma.seceti.it>
Message-ID: <Pine.LNX.4.44.0310241851570.21561-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi list i'm trying use 2.6.0-test8-mm1 and it seems to be ok in my
> machine, but I cant use radeonfb driver because my card dosent know by
> the driver, I have a radeon 9600 pro triplex 128 mb , and lspci don't
> know this card like radeonfb, so it's impossible for me test the
> radeonfb driver.

Try the latest patch at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

It is against 2.6.0-test8 vanillia.


