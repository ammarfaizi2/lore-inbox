Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVAEWeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVAEWeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 17:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVAEWeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 17:34:06 -0500
Received: from 3bit.vector.com.pl ([81.210.9.37]:28958 "EHLO
	3bit.vector.com.pl") by vger.kernel.org with ESMTP id S262623AbVAEWeE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 17:34:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
Subject: RE: [Prism54-devel] Re: [Prism54-users] Open hardware wireless cards
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Wed, 5 Jan 2005 23:34:02 +0100
Message-ID: <60E856FD577CC04BA3727AF4122D3F161134B8@3bit.vector.com.pl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Prism54-devel] Re: [Prism54-users] Open hardware wireless cards
Thread-Index: AcTzZlCkwLK6ZQ9pT36HT8ksJlpIgwADzxad
From: "Andriy Korud" <a.korud@vector.com.pl>
To: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
       "Steve Hill" <steve@nexusuk.org>
Cc: "Netdev" <netdev@oss.sgi.com>, "Jean Tourrilhes" <jt@bougret.hpl.hp.com>,
       "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>,
       <prism54-users@prism54.org>, <prism54-devel@prism54.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> AFAICT the FullMAC chipsets have reached the END OF LIFE period.

Sorry, as I know (no more details - NDA, sorry) some manufacturers are developing (and planning to continue) FullMAC 802.11g (and further) chipsets and also they are offering Linux drivers (however had no chance to test yet).

But from my point of view, SoftMAC cards are better sometimes - you have more control from drivers and can implement some interesting features (for example, madwifi Linux driver with MAC layer ported from xBSD). 

Any thoughts why we should prefer FullMAC cards over SoftMAC (except CPU usage, of course)?

regards,

--

Andriy Korud 
