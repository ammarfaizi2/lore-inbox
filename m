Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbUDOSAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUDOR5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:57:07 -0400
Received: from mail.cyclades.com ([64.186.161.6]:47583 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264377AbUDOR4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:56:35 -0400
Date: Thu, 15 Apr 2004 14:17:55 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: SATA support merge in 2.4.27
Message-ID: <20040415171755.GC3218@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Jeff Garzik sent me a SATA update to be merged in 2.4.x. 

A lot of new boxes are shipping with SATA-only disks, and its pretty bad
to not have a "stable" series without such industry-standard support.

This is the last feature to be merged on 2.4.x, and only because its quite 
necessary.

Any oppositions?
