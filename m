Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTI1LPj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 07:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTI1LPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 07:15:39 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:35222 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262416AbTI1LPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 07:15:38 -0400
Date: Sun, 28 Sep 2003 13:15:11 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Cc: detach <detach@hackaholic.org>
Subject: Re: PROBLEM: kernel 2.6-test5 rmmod: kernel NULL pointer dereference
Message-ID: <20030928131511.A2490@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	detach <detach@hackaholic.org>
References: <35776.10.0.0.50.1064747073.squirrel@mail.hackaholic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <35776.10.0.0.50.1064747073.squirrel@mail.hackaholic.org>; from detach@hackaholic.org on Sun, Sep 28, 2003 at 01:04:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wrote a CD so I did a modprobe ide-scsi ..

I believe you should not be using ide-scsi in 2.6.0-test at all. ide-cd should
suffice if you have recent cdrtools.

Rudo.
