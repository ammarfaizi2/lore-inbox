Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261671AbSJINpW>; Wed, 9 Oct 2002 09:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbSJINpV>; Wed, 9 Oct 2002 09:45:21 -0400
Received: from crack.them.org ([65.125.64.184]:25107 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261671AbSJINpV>;
	Wed, 9 Oct 2002 09:45:21 -0400
Date: Wed, 9 Oct 2002 09:51:47 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: From lines for bk-commits-*
Message-ID: <20021009135147.GA8526@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spent some time discussing this with David and we couldn't quite come to
an agreement, so I want to see what other people think...

From: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>" really
bugs me.  I want to be able to skim down the message list and see at least
"ingo" instead of "Linux Kernel Mai".  But how to do this?

My instinct is:
From: :USER: at :HOST: <linux-kernel@vger.kernel.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Which should get all mailers to do just about the right thing.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
