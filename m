Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRJOGhu>; Mon, 15 Oct 2001 02:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275381AbRJOGha>; Mon, 15 Oct 2001 02:37:30 -0400
Received: from adsl-63-207-97-74.dsl.snfc21.pacbell.net ([63.207.97.74]:46068
	"EHLO nova.botz.org") by vger.kernel.org with ESMTP
	id <S275265AbRJOGhT> convert rfc822-to-8bit; Mon, 15 Oct 2001 02:37:19 -0400
Message-Id: <200110150637.f9F6bek14014@nova.botz.org>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: Thomas Hood <jdthood@mail.com>
cc: linux-kernel@vger.kernel.org, stelian.pop@fr.alcove.com,
        ion@cs.columbia.edu, sduchene@mindspring.com, jurgen@botz.org
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp 
In-Reply-To: Message from Thomas Hood <jdthood@mail.com> 
   of "13 Oct 2001 11:40:10 EDT." <1002987648.764.23.camel@thanatos> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sun, 14 Oct 2001 23:37:39 -0700
From: Jurgen Botz <jurgen@botz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood wrote:
> Okay, here's a new major patch to the PnP BIOS driver
> which needs some testing before it's integrated.
>[...] 
> Vaio users: Please make sure that this doesn't oops.

Patched against 2.4.12-ac1, it works and doesn't oops my
VAIO PCG-N505VE.  

-j


-- 
Jürgen Botz                       | While differing widely in the various
jurgen@botz.org                   | little bits we know, in our infinite
                                  | ignorance we are all equal. -Karl Popper


