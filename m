Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262053AbTDAFpw>; Tue, 1 Apr 2003 00:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262054AbTDAFpw>; Tue, 1 Apr 2003 00:45:52 -0500
Received: from mta01.alltel.net ([166.102.165.143]:25062 "EHLO
	mta01-srv.alltel.net") by vger.kernel.org with ESMTP
	id <S262053AbTDAFpv>; Tue, 1 Apr 2003 00:45:51 -0500
Message-ID: <3E892A3A.D94A74A9@alltel.net>
Date: Tue, 01 Apr 2003 00:57:14 -0500
From: "Paul Clements (home)" <pclements@alltel.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kasper Dupont <kasperd@daimi.au.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: unexporting sys_call_table a good idea?
References: <3E891D8E.9E534400@alltel.net> <3E892117.247A17FE@daimi.au.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:
 
> You could get the address of sys_call_table from the System.map file
> and pass it as an argument to the module.

Yes, that's a good solution. I tried it and it works.

Thanks...
