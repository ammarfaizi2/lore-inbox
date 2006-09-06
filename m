Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWIFHV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWIFHV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWIFHV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:21:28 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:65416 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1751617AbWIFHV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:21:26 -0400
Subject: Re: [BUG] no sound on ppc mac mini
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <1157503851.22705.160.camel@localhost.localdomain>
References: <1152821370.6845.9.camel@localhost>
	 <1152831309.23037.31.camel@localhost.localdomain>
	 <1f1b08da0607312337l34eabc56jdee7b056acd9a71a@mail.gmail.com>
	 <1153.153.96.175.159.1154423993.squirrel@secure.sipsolutions.net>
	 <1157502802.28296.58.camel@localhost>
	 <1157503851.22705.160.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 06 Sep 2006 09:21:57 +0200
Message-Id: <1157527317.2640.0.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 10:50 +1000, Benjamin Herrenschmidt wrote:

> I remember a discussion with the Alsa folks where it was question to
> have Alsa userland automatically instanciate softvol if there is no
> volume provided by the driver, which is a better approach.

It does this, beginning with 1.0.12.

johannes
