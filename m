Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264572AbTK0SD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 13:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbTK0SD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 13:03:58 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:53956 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264572AbTK0SDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 13:03:55 -0500
Date: Thu, 27 Nov 2003 19:02:55 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: John Public <jqp@park.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Who's responsible for dpt_i2o in 2.6?
Message-ID: <20031127190255.A15282@electric-eye.fr.zoreil.com>
References: <3FC63B52.21999.6C3E856@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FC63B52.21999.6C3E856@localhost>; from jqp@park.se on Thu, Nov 27, 2003 at 05:58:36PM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Public <jqp@park.se> :
[...]
> while with no luck. After reading a couple of bug reports and such I 
> signed up on Adaptec's forum and found out that the supposed 
> maintainer, Mark Salyzyn, states
> "Incorporation into the tree can not be performed as no one is 
> designated as the gatekeeper."
> See 
> http://mbserver.adaptec.com/view.php?site=linux&bn=linux_raid&key=
> 1069782519&first=1069952140&last=1059760128
> 
> I'm not sure if he means gatekeeper out of Adaptec or gatekeeper
> into the kernel but if it's the latter could someone tell him who
> to send the patches to.

An answer has already been given, see linux-scsi (you probably want to
send your message there btw):

: From: "'Christoph Hellwig'" <hch@infradead.org>
: Date: Tue, 26 Aug 2003 17:51:35 +0100
: Subject: Re: dpt_i2o driver
: From linux-scsi-owner@vger.kernel.org  Tue Aug 26 18:58:17 2003
: To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
: Cc: Mark Haverkamp <markh@osdl.org>, linux-scsi <linux-scsi@vger.kernel.org>
: References: <0998F43EAD645A47B3F6507196DD70EA2568DE@OTCEXC01>
: 
: On Tue, Aug 26, 2003 at 11:02:48AM -0400, Salyzyn, Mark wrote:
: > I am close to completing tests surrounding the dpt_i2o driver to support 2.4
: > + 2.6 kernels as well as bigmem DMA issues. Who, if anyone, has been
: > designated as the person to accept this updated driver?
: 
: Please send it to this list. James Bottomley is official SCSI maintainer
: for 2.6 but scsi development and code review is a distributed effort
: these days.

--
Ueimor
