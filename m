Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265809AbUF2R2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUF2R2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 13:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUF2R2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 13:28:44 -0400
Received: from mx1.magmacom.com ([206.191.0.217]:30668 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S265809AbUF2R2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 13:28:41 -0400
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
From: Jesse Stockall <stockall@magma.ca>
To: Debi Janos <debi.janos@freemail.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <freemail.20040529152006.85505@fm4.freemail.hu>
References: <freemail.20040529152006.85505@fm4.freemail.hu>
Content-Type: text/plain
Message-Id: <1088530069.8367.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 29 Jun 2004 13:27:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 09:20, Debi Janos wrote:
> I am found an interesting (bug?) feature in kernels between
> 2.6.7-mm1 and 2.6.7-mm4
> 
> Some web pages eg. 
> 
> http://www.hup.hu/
> http://portal.fsn.hu/
> http://wiki.hup.hu/
> 
> is unreachable with these kernels. If i try kernel versions
> <= 2.6.7 everything is O.K. above-mentioned all web pages works.
> 

I'm seeing the same thing after upgrading to 2.6.7-mm4, 2.6.7 vanilla
does not exhibit the problem.

Also Azureus (Java Bittorrent client) crashes when it tries to open a
network socket to begin downloading. Again problem does not exist with
2.6.7.

I'm going to try a few other kernel versions to see if I can find when
this started.

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

