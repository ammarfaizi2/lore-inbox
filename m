Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTJDUDA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 16:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTJDUDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 16:03:00 -0400
Received: from mail13.speakeasy.net ([216.254.0.213]:44210 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S262719AbTJDUC7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 16:02:59 -0400
Date: Sat, 4 Oct 2003 13:02:55 -0700
Message-Id: <200310042002.h94K2tDi023290@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Rhino <rhino9@terra.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6-mm3
In-Reply-To: Andrew Morton's message of  Saturday, 4 October 2003 09:49:13 -0700 <20031004094913.77d878ec.akpm@osdl.org>
X-Zippy-Says: Is this the line for the latest whimsical YUGOSLAVIAN drama which
   also makes you want to CRY and reconsider the VIETNAM WAR?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know why that was added actually; maybe it is just left-over
> debugging code. 

Oops!  I thought I had removed all the printks before I made the patch.
That was indeed just debugging code and never intended to go in.

