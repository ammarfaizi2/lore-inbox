Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVAWU07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVAWU07 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 15:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVAWU07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 15:26:59 -0500
Received: from amun.rz.tu-clausthal.de ([139.174.2.12]:17417 "EHLO
	amun.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S261349AbVAWU06 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 15:26:58 -0500
From: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
To: linux-kernel@vger.kernel.org
Subject: Re: DVD burning still have problems
Date: Sun, 23 Jan 2005 21:26:55 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

have you checked, that cdrecord is not suid root, and growisofs/dvd+rw-tools 
is?

I had some probs, solved with a simple chmod +s growisofs :)


Glück Auf
Volker
