Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264078AbTDWPE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTDWPE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:04:59 -0400
Received: from tmi.comex.ru ([217.10.33.92]:25567 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S264078AbTDWPE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:04:58 -0400
X-Comment-To: "Martin J. Bligh"
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Wed, 23 Apr 2003 19:14:32 +0400
In-Reply-To: <18400000.1051109459@[10.10.2.4]> (Martin J. Bligh's message of
 "Wed, 23 Apr 2003 07:51:00 -0700")
Message-ID: <m3r87t8cvb.fsf@tmi.comex.ru>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.2 (gnu/linux)
References: <20030423012046.0535e4fd.akpm@digeo.com>
	<18400000.1051109459@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Martin J Bligh (MJB) writes:

 >> . I got tired of the objrmap code going BUG under stress, so it is now in
 >> disgrace in the experimental/ directory.

 MJB> Any chance of some more info on that? BUG at what point in the code,
 MJB> and with what test to reproduce?

I've seen this running fsx-linux on ext3

