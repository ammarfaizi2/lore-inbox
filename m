Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293609AbSBZWjA>; Tue, 26 Feb 2002 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293613AbSBZWiw>; Tue, 26 Feb 2002 17:38:52 -0500
Received: from CompactServ-SUrNet.ll.surnet.ru ([195.54.9.58]:33778 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S293609AbSBZWip>;
	Tue, 26 Feb 2002 17:38:45 -0500
Date: Wed, 27 Feb 2002 03:36:47 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] matroxfb_base.c - a little fix
Message-ID: <20020227033646.A27903@natasha.zzz.zzz>
In-Reply-To: <12EE5C947552@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12EE5C947552@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Tue, Feb 26, 2002 at 08:43:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, a little question: you use the (green.length == 5) test to
distinct bpp15 from bpp16 (matroxfb_base.c:509).  Why?  Is the "real"
15 not used as the bits_per_pixel's value?  Thanks in advance.
