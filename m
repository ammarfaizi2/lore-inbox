Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273670AbRIQUCd>; Mon, 17 Sep 2001 16:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273669AbRIQUCX>; Mon, 17 Sep 2001 16:02:23 -0400
Received: from ip240.cvd2.rb1.bel.nwlink.com ([207.202.151.240]:4148 "EHLO
	zot.localdomain") by vger.kernel.org with ESMTP id <S273670AbRIQUCP>;
	Mon, 17 Sep 2001 16:02:15 -0400
To: linux-kernel@vger.kernel.org
Subject: how to get version string and other metadata out of a not-loaded kernel module file?
From: Mark Atwood <mra@pobox.com>
Date: 17 Sep 2001 13:02:36 -0700
In-Reply-To: David Fries's message of "Mon, 17 Sep 2001 14:51:30 -0500"
Message-ID: <m3ofo9k2lf.fsf_-_@flash.localdomain>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there an (easy) way to query the "metadata", such as the version
strings and such, of a kernel module file, without loading it first?

