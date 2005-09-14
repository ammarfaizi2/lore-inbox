Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVINPcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVINPcQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbVINPcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:32:16 -0400
Received: from soundwarez.org ([217.160.171.123]:10897 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S965243AbVINPcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:32:15 -0400
Date: Wed, 14 Sep 2005 17:32:11 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: =?utf-8?B?SsO8cmc=?= Billeter <j@bitron.ch>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 069 release
Message-ID: <20050914153211.GA8146@vrfy.org>
References: <20050913174848.GA6702@kroah.com> <1126696727.3983.2.camel@juerg-pd.bitron.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1126696727.3983.2.camel@juerg-pd.bitron.ch>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 01:18:47PM +0200, Jürg Billeter wrote:
> On Die, 2005-09-13 at 10:48 -0700, Greg KH wrote:
> >   Makefile: cleanup install targets
> 
> The extras Makefiles haven't been updated and thus break the install
> targets. Something like the attached patch should help.

Oops, thanks for the patch. I've applied it and added a test to to our
testscript for it.

Thanks,
Kay
