Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbTJPHAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 03:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbTJPHAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 03:00:20 -0400
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:772 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S262659AbTJPHAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 03:00:18 -0400
Date: Thu, 16 Oct 2003 09:01:44 +0200 (CEST)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test7, cset-20031014_2306, SMP and ext2 problem.
Message-ID: <Pine.LNX.4.58L.0310160855440.2846@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I try to use kernel 2.6.0-test7 with cset 20031014_2306 on SMP machine
and I got strange error :
".. fs/ext2/ext2.ko Unknown symbol percpu_counter_mod"
I try to solve this problem, but can't.

Can anyone tell mi, what was wrong with this ?

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
