Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVL0MlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVL0MlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 07:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVL0MlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 07:41:08 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:20591 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932304AbVL0MlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 07:41:07 -0500
To: Nauman Tahir <nauman.tahir@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: ia_64_bit Performance difference
X-Message-Flag: Warning: May contain useful information
References: <f0309ff0512262318r6d06292u7b151f2608b286cf@mail.gmail.com>
	<1135669831.2926.11.camel@laptopd505.fenrus.org>
	<f0309ff0512270010g39d42f83rf9da794f455854a5@mail.gmail.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 27 Dec 2005 04:40:58 -0800
In-Reply-To: <f0309ff0512270010g39d42f83rf9da794f455854a5@mail.gmail.com> (Nauman
 Tahir's message of "Tue, 27 Dec 2005 13:10:16 +0500")
Message-ID: <adairtaemqt.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 27 Dec 2005 12:41:01.0285 (UTC) FILETIME=[CB17A950:01C60AE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would suggest you find the specific difference in the compiled
kernel and/or driver that is causing your driver to run slower and
then correct the issue.  That should fix your performance problems.

 - R.
