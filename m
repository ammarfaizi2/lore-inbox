Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSFDRcW>; Tue, 4 Jun 2002 13:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSFDRcU>; Tue, 4 Jun 2002 13:32:20 -0400
Received: from public1-watf3-5-cust16.watf.broadband.ntl.com ([80.0.186.16]:65276
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S316185AbSFDRcN>; Tue, 4 Jun 2002 13:32:13 -0400
Date: Tue, 4 Jun 2002 18:38:22 +0100 (BST)
From: Simon Trimmer <simon@veritas.com>
X-X-Sender: simon@localhost.localdomain
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scheduler hints
In-Reply-To: <1023206034.912.89.camel@sinai>
Message-ID: <Pine.LNX.4.44.0206041826430.26249-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jun 2002, Robert Love wrote:
> I tried to find a decent paper on the web covering scheduler hints
> (sometimes referred to as hint-based scheduling) but could not find
> anything worthwhile.  Solaris, for example, implements scheduler hints
> so perhaps the "Solaris Internals" book has some information.

Hi Robert,
This isn't my thing but my flatmate had left a copy of solaris internals on
the table ;)

This is briefly mentioned around about page 384 and appears to be targetted
at userspace processes for exactly the cases you're suggesting (holding
global resources).

A good entry point into the sun online documentation for this stuff is
schedctl_init() -
http://docs.sun.com/db?q=schedctl_init&p=/doc/816-0216/6m6ngupm0&a=view

-Simon

Simon Trimmer <simon@veritas.com>           VERITAS R&D Watford, UK



