Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSHJB22>; Fri, 9 Aug 2002 21:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSHJB22>; Fri, 9 Aug 2002 21:28:28 -0400
Received: from crisium.vnl.com ([194.46.8.33]:14096 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id <S316538AbSHJB22>;
	Fri, 9 Aug 2002 21:28:28 -0400
Date: Sat, 10 Aug 2002 02:32:11 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.30 compile fails
Message-ID: <20020810013211.GP24602@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this is of interestin to anyone I'd be happy to supply 
the .config file as well.

buffer.c: In function `__buffer_error':
buffer.c:65: warning: implicit declaration of function `show_stack'
check.c: In function `devfs_register_partitions':
check.c:470: array subscript is not an integer
make[2]: *** [check.o] Error 1
make[1]: *** [partitions] Error 2
make: *** [fs] Error 2
