Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268734AbUHTVA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268734AbUHTVA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 17:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268735AbUHTVA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 17:00:29 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59288 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268734AbUHTVA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 17:00:28 -0400
Subject: Re: GNU make alleged of "bug" (was: PATCH: cdrecord: avoiding scsi
	device numbering for ide devices)
From: Lee Revell <rlrevell@joe-job.com>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>
In-Reply-To: <20040820161524.GF16660@thundrix.ch>
References: <200408191600.i7JG0Sq25765@tag.witbe.net>
	 <200408191341.07380.gene.heskett@verizon.net>
	 <20040819194724.GA10515@merlin.emma.line.org>
	 <20040819220553.GC7440@mars.ravnborg.org>
	 <20040819205301.GA12251@merlin.emma.line.org>
	 <20040820161524.GF16660@thundrix.ch>
Content-Type: text/plain
Message-Id: <1093035629.10063.170.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 17:00:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 12:15, Tonnerre wrote:
> Salut,
> 
> On Thu, Aug 19, 2004 at 10:53:01PM +0200, Matthias Andree wrote:
> > include without leading "-" is fine. BSD make doesn't understand either
> > form.
> 
> They got .include IIRC
> 

Does anyone actually use BSD make?  gmake is your friend...

Lee

