Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272916AbTGaJTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272946AbTGaJTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:19:34 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:27804 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272916AbTGaJTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:19:30 -0400
Date: Thu, 31 Jul 2003 11:19:09 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: module-init-tools don't support gzipped modules.
Message-ID: <20030731091909.GK12849@louise.pinerecords.com>
References: <20030730183635.0B82D2C097@lists.samba.org> <2347.1059613595@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2347.1059613595@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [kaos@ocs.com.au]
> 
> On Thu, 31 Jul 2003 02:46:23 +1000, 
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >I don't want to require zlib, though.  The modutils I have (Debian)
> >doesn't support it, either.
> 
> Really?  modutils 2.4: ./configure --enable-zlib

Keith, I believe Rusty meant the standard Debian package had binaries
compiled w/o '--enable-zlib'.

(And so has Slackware btw.)

-- 
Tomas Szepe <szepe@pinerecords.com>
