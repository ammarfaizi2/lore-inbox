Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266532AbUGUQVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUGUQVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 12:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266535AbUGUQVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 12:21:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:63662 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266532AbUGUQVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 12:21:04 -0400
Date: Wed, 21 Jul 2004 12:18:16 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: Kernel Traffic Mailing List <linux-kernel@vger.kernel.org>
Subject: Turning off TCP Delayed acks
Message-ID: <Pine.GSO.4.58.0407211215420.6744@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

For an experiment, I wanted to turn off the delayed ack system in the
kernel so that there is an ack for each and every packet sent by the
source. Can anyone give me some ideas on how to go about doing this.


Thanks,
Rahul.
