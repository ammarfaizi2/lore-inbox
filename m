Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbTGCJnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 05:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265741AbTGCJnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 05:43:00 -0400
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:25168 "EHLO
	mail.trasno.org") by vger.kernel.org with ESMTP id S265718AbTGCJm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 05:42:59 -0400
To: junkio@cox.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (trivial 2.5.74) compilation fix
 drivers/mtd/mtd_blkdevs.c
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <7vbrwc3sxo.fsf@assigned-by-dhcp.cox.net> (junkio@cox.net's
 message of "Thu, 03 Jul 2003 01:39:31 -0700")
References: <7vbrwc3sxo.fsf@assigned-by-dhcp.cox.net>
Date: Thu, 03 Jul 2003 11:57:22 +0200
Message-ID: <86llvgkk59.fsf@trasno.mitica>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "junkio" == junkio  <junkio@cox.net> writes:

junkio> C does not let us declar variables in the middle of a block (yet).

It depends what do you call C :)

C99 does.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
