Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315234AbSEDW7O>; Sat, 4 May 2002 18:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315238AbSEDW7N>; Sat, 4 May 2002 18:59:13 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64777
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315234AbSEDW7N>; Sat, 4 May 2002 18:59:13 -0400
Date: Sat, 4 May 2002 15:58:02 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: =?iso-8859-1?q?Neil=20Conway?= <nconway_kernel@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH, IDE corruption, 2.4.18
In-Reply-To: <20020504121520.52836.qmail@web21510.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10205041556460.19145-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is a viable check but it the need for it shows another problem in the
code.  In the IDEDMA recovery kludges it must be losing the the hwgroup
busy state.


On Sat, 4 May 2002, Neil Conway wrote:

> Argh, humble apologies.  Just noticed that Yahoo didn't like it that my
> attachment didn't have a suffix and encoded it base64 :((
> 
> Here it is as a plain text attachment.
> 
> Neil
> 
> __________________________________________________
> Do You Yahoo!?
> Everything you'll ever need on one web page
> from News and Sport to Email and Music Charts
> http://uk.my.yahoo.com

Andre Hedrick
LAD Storage Consulting Group

