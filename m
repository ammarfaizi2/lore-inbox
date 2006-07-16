Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWGPUBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWGPUBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 16:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWGPUB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 16:01:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:39971 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932086AbWGPUB3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 16:01:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mAk35WrRkQTvksoCJCR2WSpXJLeW4aMUlSd/2EZsxVgN3ICcnLN71xm6GFsq+SJDdtG2qHGM6nnGjcq5tv5CI6PyO4QCMZKSRDwooaiAT8Dd28gC/aJ7tRxHVlyPmog2fHrr1FHu1EEnQgGTY5TFh6rIjW7DbYXdbi81zEKClrY=
Date: Sun, 16 Jul 2006 22:01:15 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Theodore Tso <tytso@mit.edu>
Cc: Lexington.Luthor@gmail.com, linux-kernel@vger.kernel.org
Subject: "Why Reuser 4 still is not in" doc (was: 'reiserFS?')
Message-Id: <20060716220115.a1891231.diegocg@gmail.com>
In-Reply-To: <20060716174804.GA23114@thunk.org>
References: <20060716161631.GA29437@httrack.com>
	<20060716162831.GB22562@zeus.uziel.local>
	<20060716165648.GB6643@thunk.org>
	<e9dsrg$jr1$1@sea.gmane.org>
	<20060716174804.GA23114@thunk.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 16 Jul 2006 13:48:04 -0400,
Theodore Tso <tytso@mit.edu> escribió:

> As far as I know not all of the problems were fixed.  And it has been
> observed that given the abuse and accusations that were directed at
> the people who did decide to review it, that it would not at all
> surprising if some (all?) of reviewers may have decided they had
> better things to do.  Getting things merged into mainline is not a
> right, and the reviewers are volunteers.....


Maybe it's too late and reiser 4 will get in in the next release, but
I've written this doc into the kernelnewbies' wiki:
http://wiki.kernelnewbies.org/WhyReiser4IsNotIn . If you disagree with
something in that doc, edit it or just answer to this mail what you want
to see in it and I'll add it myself.
