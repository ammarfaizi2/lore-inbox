Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVCWOX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVCWOX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVCWOX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:23:56 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:38412 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S262523AbVCWOXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:23:37 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Max Kellermann <max@duempel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050323135317.GA22959@roonstrasse.net>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050323135317.GA22959@roonstrasse.net>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 15:23:34 +0100
Message-Id: <1111587814.27969.86.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 14:53 +0100, Max Kellermann wrote:
> On 2005/03/22 12:49, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> > What if the few procs that he may spawn also grab so much memory so
> > your machine disappears in swap-t(h)rashing?
> 
> The number of processes is counted per user, but CPU time and memory
> consumption is counted per process.

So limiting maximum number of processes will automatically limit CPU
time and memory consumption per user?

--
Natanael Copa


