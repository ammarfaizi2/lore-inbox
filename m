Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWCWRTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWCWRTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWCWRTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:19:40 -0500
Received: from poup.poupinou.org ([195.101.94.96]:23358 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1751023AbWCWRTj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:19:39 -0500
Date: Thu, 23 Mar 2006 18:19:36 +0100
To: "Brace, Don" <dab@hp.com>
Cc: ISS StorageDev <iss_storagedev@hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] performance issues for cciss driver.
Message-ID: <20060323171936.GA3144@poupinou.org>
References: <20060323085711.GA1281@poupinou.org> <B8857D46D8618E48B51E0199BB9C26F31A3878@cceexcsp04.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8857D46D8618E48B51E0199BB9C26F31A3878@cceexcsp04.americas.cpqcorp.net>
User-Agent: Mutt/1.5.9i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 09:06:12AM -0600, Brace, Don wrote:
> I am currently working on a correction to this problem.
> 
> We are currently working on the best value for the read-ahead setting.
> This includes no read-ahead.
> 
> The next release should be better.

Thanks.  I've actually setup an rc script for some of our servers
where this kind of problem happens in the meantime.

BTW I can test on another server any patch you please.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
