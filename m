Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264352AbUE3URN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbUE3URN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 16:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUE3URN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 16:17:13 -0400
Received: from gate.firmix.at ([80.109.18.208]:36494 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S264352AbUE3URK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:17:10 -0400
Subject: Re: Why is proper NTFS-driver difficult?
From: Bernd Petrovitsch <bernd@firmix.at>
To: linux-kernel@vger.kernel.org
In-Reply-To: <40BA1FD5.9080902@minimum.se>
References: <40BA1FD5.9080902@minimum.se>
Content-Type: text/plain
Organization: http://www.firmix.at/
Message-Id: <1085948226.21617.1.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 30 May 2004 22:17:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-30 at 19:54, Martin Olsson wrote:
> I was wondering why is there no Linux NTFS-driver which allows full 
> writing etc? Is there something that makes this particular difficult to 
> implement? I mean Linux supports so many file systems, why has proper 
> NTFS support been neglected?

Because there is no official documentation which will cover future
versions of NTFS (which may come with the next patch^Whotfix - let alone
service pack).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


