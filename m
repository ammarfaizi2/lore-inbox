Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWHaLty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWHaLty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 07:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWHaLty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 07:49:54 -0400
Received: from corky.net ([212.150.53.130]:33714 "EHLO zebday.corky.net")
	by vger.kernel.org with ESMTP id S932095AbWHaLty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 07:49:54 -0400
Message-ID: <44F6CCC7.6090606@corky.net>
Date: Thu, 31 Aug 2006 12:49:27 +0100
From: Just Marc <marc@corky.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dspam as an incoming message filter on LKML
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP on CorKy.NeT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sure many of you have experience with lots of different of spam 
filters, at least some of you will know how good and effective DSPAM is.

What I propose is simple, after we teach DSPAM what is ham and what is 
spam (a quick process on LKML) have one person who will volunteer
to weed out any false positives (if any) for a short period of time, 
following that we can just let DSPAM do its magic and enjoy a totally 
spam free
LKML.  

The chance of false positives with the kind of highly specific topics 
and keywords discussed on LKML is extremely small.

Comments?

Marc
