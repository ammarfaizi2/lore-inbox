Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVBUFnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVBUFnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 00:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVBUFnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 00:43:40 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:28563 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261889AbVBUFni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 00:43:38 -0500
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Sean <seanlkml@sympatico.ca>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Chris Friesen <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
References: <seanlkml@sympatico.ca>
	<4912.10.10.10.24.1108675441.squirrel@linux1>
	<200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl>
	<1451.10.10.10.24.1108713140.squirrel@linux1>
	<20050218162729.GA5839@thunk.org>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Mon, 21 Feb 2005 14:43:19 +0900
In-Reply-To: <20050218162729.GA5839@thunk.org> (Theodore Ts'o's message of
 "Fri, 18 Feb 2005 11:27:29 -0500")
Message-ID: <buomzty5uyw.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:
> The "cost" of using BK seems to be primarily more theoretical, and
> ideological, than real.

I've never used BK (not allowed to), but some things I've read about it
sound quite annoying.  For instance:

 * Every source tree contains your entire repository => massive disk usage

 * Must "unlock" files before working on them ("bk edit"); I recall
   doing this with RCS, and it was, well, a real pain.

-Miles
-- 
"Whatever you do will be insignificant, but it is very important that
 you do it."  Mahatma Ghandi
