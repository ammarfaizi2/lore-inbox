Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbVFWI3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbVFWI3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbVFWIYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:24:11 -0400
Received: from web33309.mail.mud.yahoo.com ([68.142.206.124]:50608 "HELO
	web33309.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262617AbVFWHZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:25:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sz8AMTVXQYFP9qOrFKlKs29how7I5BRVLyleN9sl7mkPEUkoGLsApkPCoyc3mdd1mgh7jLoUX2rTh+2SkULkiXoAkXUz2It4Mj5K74+b9nPczmwLjlXtGe7ym+5MSK2CWZZcRSccb0uiGJOT6gl+EsNsHx/V3QG8DwMX/vRNwCI=  ;
Message-ID: <20050623072502.21473.qmail@web33309.mail.mud.yahoo.com>
Date: Thu, 23 Jun 2005 00:25:02 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: locks held by the kernel processes
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there anyway to know the locks held by the kernel
processes at a given point of time and how long the
lock was held.
I am particularly interested in kscand.

-Thanks.


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com
