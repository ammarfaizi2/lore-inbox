Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTI1Sqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTI1Sqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:46:45 -0400
Received: from h24-70-73-190.ca.shawcable.net ([24.70.73.190]:22145 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262675AbTI1Spj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:45:39 -0400
Date: Sun, 28 Sep 2003 11:45:33 -0700
From: Jack Bowling <jbinpg@shaw.ca>
To: redhat-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: test5+ bombing on uhci-hcd
Message-ID: <20030928184532.GA31526@nonesuch.ca.shawcable.net>
Reply-To: Jack Bowling <jbinpg@shaw.ca>
Mail-Followup-To: Jack Bowling <jbinpg@shaw.ca>, redhat-list@redhat.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect there are a few RHers tracking the mainline test kernels. If
so, has anybody run into a problem with uhci-hcd loading? My RH 8 box hangs
instantly with no way of recovery except for a reset. This started with
test5 and continues with test6. According to the changelogs there have
been many USB changes in the past couple of releases as to be expected.
But I'll make a diff and try to wade through it anyway. Just thought I'd
put out an initial feeler.

-- 
Jack Bowling
mailto: jbinpg@shaw.ca
