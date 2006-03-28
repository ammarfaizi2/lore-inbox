Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWC1XEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWC1XEy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWC1XEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:04:54 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:63342 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964795AbWC1XEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:04:53 -0500
Date: Tue, 28 Mar 2006 17:03:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: BUG in Linux 2.6.16/2.6.16.1 (compilation failure of third party
 software)
In-reply-to: <5Vr7d-4VR-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: thgodef@nerim.net
Message-id: <4429C0C9.7050303@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Vr7d-4VR-15@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry Godefroy wrote:
> Paragon_NTFS_3.x.v5.1 fails to compile (with gcc v3.4.3) with the following
> errors:

I don't think compilation failures of out-of-tree drivers is considered 
a bug. It's the responsibility of those drivers to keep up to date with 
kernel changes.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

