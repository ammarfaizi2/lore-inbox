Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbTDQQ4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 12:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTDQQ4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 12:56:32 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:60838 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261717AbTDQQ4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 12:56:31 -0400
Date: Thu, 17 Apr 2003 10:10:34 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More USB fixes for 2.5.67
Message-ID: <20030417171034.GA5916@kroah.com>
References: <1050559505786@kroah.com> <10505595052196@kroah.com> <20030417081759.A19615@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030417081759.A19615@one-eyed-alien.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 08:18:00AM -0700, Matthew Dharm wrote:
> Umm... this patch is only needed on 2.4.x -- 2.5.x doesn't send START_STOP
> on it's own anymore, and limiting that command is the only thing this entry
> seems to do.
> 
> I don't think this should be applied.

Ah, ok, I'll revert it.

Thanks for letting me know.

greg k-h
