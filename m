Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWAEPcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWAEPcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWAEPcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:32:14 -0500
Received: from rtr.ca ([64.26.128.89]:10138 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932079AbWAEPcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:32:12 -0500
Message-ID: <43BD3BEC.5060309@rtr.ca>
Date: Thu, 05 Jan 2006 10:31:56 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: gcoady@gmail.com
Cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org,
       davej@redhat.com
Subject: Re: oops pauser. / boot_delayer
References: <20060104221023.10249eb3.rdunlap@xenotime.net> <E1EuPZg-0008Kw-00@calista.inka.de> <6appr1djnkhaa35cjahs22itittduia9bf@4ax.com>
In-Reply-To: <6appr1djnkhaa35cjahs22itittduia9bf@4ax.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
>
> No, after oops, console dead, very dead . . . no scrollback :(

This mis-feature is beginning to annoy more and more.

I seem to recall that "in the old days" (1990s),
this was NOT the case:  scrollback still worked from oops.

I wonder if perhaps a better feature here would be to fix that again?

Cheers
