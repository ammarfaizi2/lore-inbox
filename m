Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbTGUK2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 06:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269623AbTGUK2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 06:28:05 -0400
Received: from tmi.comex.ru ([217.10.33.92]:36537 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S269621AbTGUK2D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 06:28:03 -0400
X-Comment-To: =?iso-8859-2?q?G=E1bor_L=E9n=E1rt?=
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: buffer layer error at fs/buffer.c:416
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Mon, 21 Jul 2003 14:42:43 +0000
In-Reply-To: <20030721103330.GC17588@vega.digitel2002.hu>
 =?iso-8859-2?q?(G=E1bor_L=E9n=E1rt's?= message of "Mon, 21 Jul 2003
 12:33:30 +0200")
Message-ID: <87fzl0ym8s.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <20030721093021.GA16319@vega.digitel2002.hu>
	<20030721103330.GC17588@vega.digitel2002.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


are you sure it was clean 2.6.0-test1?

>>>>> Gábor Lénárt (GL) writes:

 GL> BTW, additional information: I've turned feature dir_index with tune2fs,
 GL> but I did not run "fsck -fD" on my filesystems ...

 GL> On Mon, Jul 21, 2003 at 11:30:21AM +0200, Gábor Lénárt wrote:
 >> When trying with 2.6.0-test1 everything seems to be fine. But when
 >> installing huge deb packages (Debian distribution) _AND_ doing eg some huge
 >> copy together, the great amount of disk i/o triggers somewhere a problem. At
 >> least I got messages like:
 >> 
 >> http://download.lgb.hu/bufferlayererror.txt
 >> 
 >> buffer layer error at fs/buffer.c:416
 GL> [...]

 GL> - Gábor (larta'H)
 GL> -
 GL> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 GL> the body of a message to majordomo@vger.kernel.org
 GL> More majordomo info at  http://vger.kernel.org/majordomo-info.html
 GL> Please read the FAQ at  http://www.tux.org/lkml/

