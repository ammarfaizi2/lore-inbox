Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbUKQXRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbUKQXRK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUKQXP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:15:26 -0500
Received: from webmail.cs.unm.edu ([64.106.20.39]:16585 "EHLO mail.cs.unm.edu")
	by vger.kernel.org with ESMTP id S262632AbUKQXMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:12:43 -0500
Date: Wed, 17 Nov 2004 16:12:33 -0700 (MST)
From: Sharma Sushant <sushant@cs.unm.edu>
To: linux-kernel@vger.kernel.org
Subject: max agruments in system_calls
Message-ID: <Pine.LNX.4.60.0411171608250.30215@chawla.cs.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Scanner: exiscan *1CUYyX-0000rL-00*5PU4fdWa0BE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All
Can some one tell me, if I want to implement a system call with more than 
6 arguments in it, how should I do it? I am using kernel 2.6.3.
I know I can use struct and stuff arguments inside it, but I want to 
use more than 6 different arguments.

Thanks
-Sushant

ps: please cc the reply to me

Sushant Sharma 		Computer Science @ UNM
http://cs.unm.edu/~sushant
