Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWBMIZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWBMIZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWBMIZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:25:38 -0500
Received: from boetes.org ([213.84.147.9]:64734 "HELO boetes.org")
	by vger.kernel.org with SMTP id S1751219AbWBMIZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:25:38 -0500
Date: Mon, 13 Feb 2006 09:24:56 +0059
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: OpenBSD driver for nforce-based ethernetcards.
Message-ID: <20060213082519.GN12484@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just read this announcement on a well known OpenBSD forum:

  http://undeadly.org/cgi?action=article&sid=20060206150238&mode=expanded


So if anyone is interested in writing a driver for Linux for the
nvidia ethernet cards: That's a nice place to start.


The sourcecode can be found over here:

  http://www.openbsd.org/cgi-bin/cvsweb/src/sys/dev/pci/

Under the name if_nfe*



# Han
