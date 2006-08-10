Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWHJASi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWHJASi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWHJASh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:18:37 -0400
Received: from mail.visionpro.com ([63.91.95.13]:59797 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S932444AbWHJASf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:18:35 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Upgrading kernel across multiple machines
Date: Wed, 9 Aug 2006 17:18:33 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA001167638@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Upgrading kernel across multiple machines
Thread-Index: Aca8AZLV6GOIEP3UTMyHJz2JY/99YwAEOfsg
From: "Brian D. McGrew" <brian@visionpro.com>
To: "David Lloyd" <dmlloyd@flurg.com>
Cc: "Sam Ravnborg" <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried copying over the initrd as well as making a new one!

:b!

-----Original Message-----
From: David Lloyd [mailto:dmlloyd@flurg.com] 
Sent: Wednesday, August 09, 2006 3:18 PM
To: Brian D. McGrew
Cc: Sam Ravnborg; linux-kernel@vger.kernel.org
Subject: Re: Upgrading kernel across multiple machines

On Wed, 2006-08-09 at 15:08 -0700, Brian McGrew wrote:
> It would appear that way; but I assure you, the modules are in
> /lib/modules/2.6.16.16/

Maybe you forgot to copy over your initrd image?

- DML

