Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVKUSGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVKUSGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVKUSGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:06:47 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:37048
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932435AbVKUSGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:06:47 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: "Christopher Friesen" <cfriesen@nortel.com>
Subject: Re: [RFC] Documentation dir is a mess
Date: Mon, 21 Nov 2005 12:05:12 -0600
User-Agent: KMail/1.8
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <438069BD.6000401@gmail.com> <200511211028.28944.rob@landley.net> <4381F957.3070007@nortel.com>
In-Reply-To: <4381F957.3070007@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511211205.12861.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 10:44, Christopher Friesen wrote:
> > Documentation/filesystems/proc.txt?
>
> This one seems obvious:
>
> Documentation/fs/proc.txt

Except that I picked proc.txt because the contents of the file are really 
about the whole source tree.  (This isn't documentation about the proc 
filesystem infrastructure, it's documentation about all known users of that 
infrastructure...)

Again, doesn't quite clearly map onto a location in the source tree...

Rob
