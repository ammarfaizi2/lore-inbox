Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbUBIUPL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265420AbUBIUPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:15:11 -0500
Received: from farley2.Colorado.EDU ([128.138.129.103]:8951 "EHLO
	farley2.Colorado.EDU") by vger.kernel.org with ESMTP
	id S265413AbUBIUPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:15:07 -0500
From: moseleyt@colorado.edu
Message-ID: <1076357703.4027ea47ed2e3@webmail.colorado.edu>
Date: Mon,  9 Feb 2004 13:15:03 -0700
To: linux-kernel@vger.kernel.org
Subject: halting processor in SMT(Hyperthreading) system
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am doing research involving optimal scheduling for Hyperthreading systems.  I
was curious if there was an easy way to arbitrarily halt/wake up a processor
other than the one being run on from schedule().

Thanks

Tipp

