Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbTI3TWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 15:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTI3TWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 15:22:09 -0400
Received: from [62.81.235.113] ([62.81.235.113]:19928 "EHLO smtp13.eresmas.com")
	by vger.kernel.org with ESMTP id S261677AbTI3TWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 15:22:07 -0400
Message-ID: <3F79D7D4.6090204@wanadoo.es>
Date: Tue, 30 Sep 2003 21:21:56 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com.br>,
       "Mukker, Atul" <atulm@lsil.com>, linux-megaraid-devel@dell.com
Subject: RE: Megaraid does not work with 2.4.22
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> On Wed, 24 Sep 2003, Mukker, Atul wrote:
> 
>> Marcelo,
>> 
>> What are your plans to integrate the 1.18k as well as 2.00.9 megaraid
>> drivers in the mainstream kernels.
> 
> Atul,
> 
> It depends on what they change and how extensively they have been tested.

kernel driver 1.xx is frozen since Dec-2002. Latest 1.xx _only_ fixes bugs
and adds support for ioctls on amd64. Not too much exciting.

2.xx driver adds support for latest hardware, MegaRAID Ultra320 RAID boards
(518, 520, 531, 532.). It was developed since Nov-2002 and it is included
in Red Hat Enterpise Linux 2.1 since May-2003.

Matt Domsch of Dell now is distribuyed both to their customers.
So they should be ready for official kernel inclusion.

I don't know what is the opinion of other people :-?
Maybe linux-scsi members hold other opinion.

> Are they in 2.6 already? 

no.

-thanks-

-- 
SCO before, Smoking Crack Often now.

