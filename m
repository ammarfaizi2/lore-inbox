Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWFKODI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWFKODI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 10:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWFKODI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 10:03:08 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:54794 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751581AbWFKODI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 10:03:08 -0400
Message-ID: <448C2298.5000409@argo.co.il>
Date: Sun, 11 Jun 2006 17:03:04 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Theodore Tso <tytso@mit.edu>, David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
References: <Pine.LNX.4.64.0606110952560.29891@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0606110952560.29891@cuia.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2006 14:03:06.0242 (UTC) FILETIME=[C32AF620:01C68D5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
>
> On Sun, 11 Jun 2006, Theodore Tso wrote:
>
> > Actually, I post as "tytso@mit.edu" (but always relayed through my
> > mail relay at thunk.org).  :-)
>
> That will no longer work reliably if Matti enables SPF,
> since thunker.thunk.org is not in the mit.edu SPF record.
> At least it's not a -all...
>

Can't it be corrected by having the thunk.org MTA relay messages from 
@mit.edu through the MIT MTA? Presumably the MIT MTA will only be open 
to authenticated users.

-- 
error compiling committee.c: too many arguments to function

