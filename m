Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTJIQFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJIQFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:05:38 -0400
Received: from smtp11.eresmas.com ([62.81.235.111]:24282 "EHLO
	smtp11.eresmas.com") by vger.kernel.org with ESMTP id S262221AbTJIQFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:05:37 -0400
Message-ID: <3F858731.1020706@wanadoo.es>
Date: Thu, 09 Oct 2003 18:05:05 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: two sym53c8xx.o modules
References: <Pine.LNX.4.44.0310090826290.2569-100000@logos.cnet>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> One should not have both drivers loaded at the same time, so I think this
> is alright.

problem is "modprobe sym53c8xx" command loads at *same time* both.
I sent you a patch long time ago http://marc.theaimsgroup.com/?l=linux-kernel&m=105262722022952&w=2
;-)

-thanks-

