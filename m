Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUHVGSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUHVGSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 02:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266258AbUHVGSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 02:18:15 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:1524 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S266252AbUHVGSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 02:18:09 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Brad Campbell'" <brad@wasp.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sun, 22 Aug 2004 09:18:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <41283A74.101@wasp.net.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSID51oQIgzwsw3R/ysjBlwKGiIcgACHgPg
Message-Id: <S266252AbUHVGSJ/20040822061809Z+1736@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Absolutely, that would correct the problem with the best possible
resolution.

-----Original Message-----
From: Brad Campbell [mailto:brad@wasp.net.au] 
Sent: Sunday, August 22, 2004 8:17 AM
To: Josan Kadett
Cc: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

So if we took any packet that came in from 192.168.1.1 and substituted
192.178.77.1 for the Source 
address and then re-calculated the IP checksum you would be up and running?

Regards,
Brad



