Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVDFMOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVDFMOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVDFMOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:14:30 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:51471 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S262180AbVDFMNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:13:19 -0400
From: Joe Button <vger.kernel.org@joebutton.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc1: Mouse stopped working
Date: Wed, 6 Apr 2005 13:19:39 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061319.39431.vger.kernel.org@joebutton.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

My mouse stopped working in x.org with 2.6.12-rc1. Problem is still there in 
2.6.12-rc2. Works on 2.6.11.x with same .config (except for make oldconfig / 
defaults).

Mouse is ImPs2, xorg.conf is using /dev/input/mouse0, which seems to be 
present. Board is Asus p4p800 deluxe.

More info available on request.

I'm not subscribed to the list so please cc any response.

Cheers,

Joe
