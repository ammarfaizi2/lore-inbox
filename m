Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTE2Sq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 14:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTE2Sq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 14:46:56 -0400
Received: from sunserv.kfki.hu ([148.6.0.5]:60811 "EHLO sunserv.kfki.hu")
	by vger.kernel.org with ESMTP id S262497AbTE2Sqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 14:46:55 -0400
Date: Thu, 29 May 2003 21:00:07 +0200
From: =?iso-8859-1?Q?Cs=E1rdi_G=E1bor?= <csardi@rmki.kfki.hu>
To: linux-kernel@vger.kernel.org
Subject: Memory page references
Message-ID: <20030529210007.E16598@bifur.rmki.kfki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
X-PGP-Key: http://www.rmki.kfki.hu/~csardi/pubkey.asc
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'd like to extract the (virtual) memory page sequences
referenced by a given process. Do you have any idea how I could
manage this? Is it possible at least? I have i386 hardware, if
this is important...

(I intend to study the behaviour of programs corncerning memory
usage, eg. their typical reference sequences (if any).)

TIA,
Gabor


-- 
Csardi Gabor <csardi@rmki.kfki.hu>    MTA RMKI, ELTE TTK
