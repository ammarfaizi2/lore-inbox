Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTLOR74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTLOR74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:59:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28606 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263850AbTLOR7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:59:55 -0500
Message-ID: <3FDDF68F.6010903@pobox.com>
Date: Mon, 15 Dec 2003 12:59:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Toad <toad@amphibian.dyndns.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11,
 reading an apparently duff DVD-R
References: <20031215135802.GA4332@amphibian.dyndns.org> <Pine.LNX.4.58.0312150715410.1488@home.osdl.org> <3FDDD923.30509@pobox.com> <20031215174908.GA29901@amphibian.dyndns.org>
In-Reply-To: <20031215174908.GA29901@amphibian.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toad wrote:
> I've been completely unable to get cdrtools to compile... The version in
> debian is 2.0a19, which works with IDE-SCSI, and doesn't work without
> it. The RPM from the oss-dvd extension site doesn't work either without
> IDE-SCSI. Nor does dvd+rwtools. Anyone attempting to write DVDs will
> have real problems if IDE-SCSI is removed, judging by this experience.

Well, it sounds like we are having real problems _with_ IDE-SCSI, too ;-)

