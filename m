Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265741AbUEZRkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265741AbUEZRkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265739AbUEZRkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:40:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54215 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265741AbUEZRkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 13:40:23 -0400
Date: Wed, 26 May 2004 13:40:18 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: VIA "Velocity" Gigabit ethernet driver
Message-ID: <20040526174018.GA29119@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A cleaned up and 2.6 ported VIA velocity driver is now available on
ftp://people/redhat.com/alan/Kernel/. This is an initial clean up and
port to 2.6. It isn't by any means polished yet. Please send test results
and patches to me (I don't currently read linux-kernel).

It should work on both 32 and 64bit little endian, it won't work on big
endian boxes yet.

Alan

