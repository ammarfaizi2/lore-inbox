Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757083AbWK3Dsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083AbWK3Dsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 22:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757081AbWK3Dsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 22:48:33 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:58633 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1755309AbWK3Dsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 22:48:32 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200611300348.kAU3mN9w001555@clem.clem-digital.net>
Subject: Re: 2.6.19 panic on boot -- i386
To: randy.dunlap@oracle.com (Randy Dunlap)
Date: Wed, 29 Nov 2006 22:48:23 -0500 (EST)
Cc: clem@clem.clem-digital.net (Pete Clements),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20061129191736.9c50d61e.randy.dunlap@oracle.com>
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap
  > > 2.6.19 panics at boot. Good up through rc6-git11.
  > > Hand copied screen below.
  > 
  > Try the patch that DaveM recently posted:
  >   http://lkml.org/lkml/2006/11/29/335
  > 
  > ---
  > ~Randy
  > 
That fixed it.

-- 
Pete Clements 
