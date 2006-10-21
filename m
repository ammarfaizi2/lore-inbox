Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993147AbWJUSPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993147AbWJUSPG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766641AbWJUSPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:15:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:7362 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S637745AbWJUSPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:15:01 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] [11/19] i386: Fix fake return address
Date: Sat, 21 Oct 2006 20:14:21 +0200
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
References: <20061021 651.356252000@suse.de> <20061021165131.4FDD813C4D@wotan.suse.de> <453A6320.30009@goop.org>
In-Reply-To: <453A6320.30009@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610212014.22052.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yep, that's better than my patch, but the comment is out of date.

Sorry, i changed it while doing a merge (original patch rejected
somewhere) but forgot to adapt the description

-Andi
