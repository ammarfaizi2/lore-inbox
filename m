Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTJFT4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTJFT4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:56:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:60648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261605AbTJFT43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:56:29 -0400
Date: Mon, 6 Oct 2003 12:56:27 -0700
From: cliff white <cliffw@osdl.org>
To: linuxppc-dev@list.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Keyboard repeat broken on iBook - linuxppc-2.5 latest
Message-Id: <20031006125627.55e5fc8c.cliffw@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Symptoms are identical to those reported on Bugzilla Bug #1025

Kernel: lastest from ppc.bkbits.net/linuxppc-2.5 
(10/06/03 AM)

Single keypress produces > 2 repeated characters. Can't even login to
the system, as i cannot enter my uid. 

Last successful kernel was from this changeset:

ChangeSet@1.1065, 2003-09-26 22:33:42+10:00, paulus@samba.org

Everything since then either doesn't complie, or has the keyboard problem

Further information on request. 

cliffw
