Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVBOXNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVBOXNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVBOXNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:13:52 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:8422 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261937AbVBOXMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:12:37 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Anthony DiSante <theant@nodivisions.com>
Subject: Re: two Oopses on 2.6.10
Date: Tue, 15 Feb 2005 18:12:37 -0500
User-Agent: KMail/1.7.92
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <421279EC.80108@nodivisions.com>
In-Reply-To: <421279EC.80108@nodivisions.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502151812.37991.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2005 05:38 pm, Anthony DiSante wrote:
> # ksymoops -K -o /lib/modules/2.6.10-1.9_FC2smp/ -m
> /boot/System.map-2.6.10-1.9_FC2smp oops.01 >ksymoops.01
You seem to be using a Redhat/Fedora kernel and not a stock 2.6.10 - Two 
options - Either report this bug at https://bugzilla.redhat.com or reproduce 
it with a recent stock kernel like 2.6.11-rc4 and report it if you do 
reproduce it.

Parag
