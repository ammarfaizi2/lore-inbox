Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318929AbSHTO2w>; Tue, 20 Aug 2002 10:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318939AbSHTO2w>; Tue, 20 Aug 2002 10:28:52 -0400
Received: from mout0.freenet.de ([194.97.50.131]:60114 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S318929AbSHTO2v>;
	Tue, 20 Aug 2002 10:28:51 -0400
Date: Tue, 20 Aug 2002 16:32:49 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre4
Message-ID: <20020820143249.GA1440@prester.freenet.de>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208191944210.10105-100000@freak.distro.conectiva> <20020820053619.GA9401@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020820053619.GA9401@alpha.home.local>
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy!

On Tue, 20 Aug 2002, Willy Tarreau wrote:

> Compiled and loaded JFS, but not tested.

In case you use a gcc compiler 3.1+ please test your jfs extensively. dbench
works good for me.
I have had problem with JFS compiled with gcc 3.1+. It causes oopses that
stop any fs activity and the machine freezes.

Regards,
Axel
