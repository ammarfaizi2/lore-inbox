Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWDCPSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWDCPSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWDCPSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:18:36 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:56984 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751642AbWDCPSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:18:35 -0400
Date: Mon, 3 Apr 2006 11:18:33 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: =?iso-8859-1?q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
cc: linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] packet/socket owner match (fireflier) using skfilter
In-Reply-To: <200604021240.21290.edwin@gurde.com>
Message-ID: <Pine.LNX.4.64.0604031117070.7743@d.namei>
References: <200604021240.21290.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="537530981-1417147764-1144077513=:7743"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--537530981-1417147764-1144077513=:7743
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Sun, 2 Apr 2006, Török Edwin wrote:

> Before continuing the work on it, I ask for your advice, and comments on what 
> I've done so far.

I would suggest dropping your LSM stuff and just using SELinux.  It's 
crazy to try and reinvent it.



- James
-- 
James Morris
<jmorris@namei.org>
--537530981-1417147764-1144077513=:7743--
