Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272360AbTHIN6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 09:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272359AbTHIN6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 09:58:23 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:10625
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S272396AbTHINyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 09:54:06 -0400
Date: Sat, 9 Aug 2003 09:53:26 -0500 (CDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: [Bug 973] Re: Linux 2.6.0-test3:  Presario laptop panic
In-Reply-To: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0308090945150.2587-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please see Bugzilla for the gory details.  Synopsis is that my Preario 
laptop panics on boot:

Unable to handle kernel pagin request at virtual address c035800

EIP 0060:[<c014CE95>]
EIP is at store_stackinfo+0x85/0xc0

This behaviour continues since 2.5.74-bk1.  


