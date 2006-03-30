Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWC3BTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWC3BTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWC3BTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:19:39 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:59099 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1751418AbWC3BTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:19:38 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603300119.k2U1JSRF002613@clem.clem-digital.net>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
To: akpm@osdl.org (Andrew Morton)
Date: Wed, 29 Mar 2006 20:19:28 -0500 (EST)
Cc: clem@clem.clem-digital.net (Pete Clements),
       klassert@mathematik.tu-chemnitz.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060329171030.3d475bcb.akpm@osdl.org>
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton
  > 
  > Oh damn.  So you're sure that 3c59x.global_enable_wol=0 actually makes the
  > driver behave better?
  > 

I seem to have lost the ability to time out. Let me get back to a fresh 16
build and work forward again.
--
Pete Clements
