Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSGKNIO>; Thu, 11 Jul 2002 09:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317834AbSGKNIN>; Thu, 11 Jul 2002 09:08:13 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:11178 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317833AbSGKNIM>; Thu, 11 Jul 2002 09:08:12 -0400
Date: Thu, 11 Jul 2002 14:35:46 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
       Emmanuel Fuste <fuste@worldnet.fr>, Peter De Schrijver <p2@mind.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: m68k and input api
Message-ID: <20020711143546.D1196@linux-m68k.org>
References: <Pine.LNX.4.44.0207101547420.11248-100000@www.transvirtual.com> <Pine.GSO.4.21.0207110829210.8371-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0207110829210.8371-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Thu, Jul 11, 2002 at 08:30:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

isn't it time to simply drop in all of the input layer into 
our 2.5 CVS branch and fix it later? I certainly won't mind if
my keyboard doesn't work for a while and I am sure that fixing 
it will be actually *much* easier than hunting together all
the input-api pieces.

Richard
