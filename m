Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264854AbUEJQWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264854AbUEJQWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264852AbUEJQWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:22:23 -0400
Received: from [161.142.8.30] ([161.142.8.30]:54788 "EHLO frodo.cs.usm.my")
	by vger.kernel.org with ESMTP id S264854AbUEJQWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:22:19 -0400
Subject: Re:  State of linux checkpointing?
From: Nur Hussein <obiwan@anomalistic.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1084206228.1293.18.camel@gandalf.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 11 May 2004 00:23:48 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors wrote:

> Oooh. Shiny.
> 

There's also another checkpointing project called epckpt written
by Eduardo Pinheiro, which I've created into a kernel patch, ported
to 2.4.22 and added some other stuff for my Masters project:

http://marauder.googgun.com/~obiwan/kernel

You can download both epckpt and the other stuff at the URL above, if
anyone's interested. Unfortunately though, it's also only for 2.4.x.

-= Nur Hussein =-

