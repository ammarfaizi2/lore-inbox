Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUFQRa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUFQRa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUFQRa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:30:56 -0400
Received: from email.careercast.com ([216.39.101.233]:1670 "HELO
	email.careercast.com") by vger.kernel.org with SMTP id S261205AbUFQRay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:30:54 -0400
Subject: Re: Building a large Raid6 SATA array
From: Clint Byrum <cbyrum@spamaps.org>
To: Raphael Jacquot <Raphael.Jacquot@imag.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40D1B8A2.7030707@imag.fr>
References: <40D1B8A2.7030707@imag.fr>
Content-Type: text/plain
Message-Id: <1087493452.18910.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 17 Jun 2004 10:30:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 08:28, Raphael Jacquot wrote:
> Hi,
> I am researching the building of the above for work, and need hardware 
> selection advice.
> 

We've had a 3ware Escalade 8506-8 in production for about 3 months now,
with 4x250GB WDC SATA drives in software RAID5 mode.

Before it went live though, I ran some checks on RAID6, as well as some
filesystem stuff. Benchmarks are what they are.. but I think the results
are still relevant:

http://spamaps.org/raidtests.php


