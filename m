Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbTGUKSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 06:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269612AbTGUKSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 06:18:30 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:62125 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S269602AbTGUKSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 06:18:30 -0400
Date: Mon, 21 Jul 2003 12:33:30 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: buffer layer error at fs/buffer.c:416
Message-ID: <20030721103330.GC17588@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <20030721093021.GA16319@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030721093021.GA16319@vega.digitel2002.hu>
X-Operating-System: vega Linux 2.6.0-test1 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, additional information: I've turned feature dir_index with tune2fs,
but I did not run "fsck -fD" on my filesystems ...

On Mon, Jul 21, 2003 at 11:30:21AM +0200, Gábor Lénárt wrote:
> When trying with 2.6.0-test1 everything seems to be fine. But when
> installing huge deb packages (Debian distribution) _AND_ doing eg some huge
> copy together, the great amount of disk i/o triggers somewhere a problem. At
> least I got messages like:
> 
> http://download.lgb.hu/bufferlayererror.txt
> 
> buffer layer error at fs/buffer.c:416
[...]

- Gábor (larta'H)
