Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263558AbUDUR1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbUDUR1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 13:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbUDUR1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 13:27:10 -0400
Received: from smtp.tiscali.ch ([212.40.5.52]:14733 "EHLO smtp.tiscali.ch")
	by vger.kernel.org with ESMTP id S263558AbUDUR1G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 13:27:06 -0400
content-class: urn:content-classes:message
Subject: RE: tcp vulnerability?  haven't seen anything on it here...
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Wed, 21 Apr 2004 19:27:01 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Message-ID: <435F241B01CDFC44B50865371254BC3702426157@ch-flu-exchange>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: tcp vulnerability?  haven't seen anything on it here...
Thread-Index: AcQnxBSVWEW8PbtlQQCb1HJkhbb7gwAAXNzA
From: "Fabian Uebersax" <fabian.uebersax@ch.tiscali.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Obvious solution would be to use a small window, which would cost
> performance.  Different solution would be to use a different window
> size for reset, like, say, 1.  Not sure if that would still be
> standard, though.
 

IETF released the following draft with possible fixes:
http://www.ietf.org/internet-drafts/draft-ietf-tcpm-tcpsecure-00.txt


cheers,
	- Fabian
