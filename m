Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVC0Sje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVC0Sje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVC0Sjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:39:33 -0500
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:50657 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261395AbVC0Sj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:39:28 -0500
Date: Sun, 27 Mar 2005 13:39:27 -0500
From: Nick Orlov <bugfixer@list.ru>
Subject: Re: 2.6.12-rc1-mm3: class_simple API
In-reply-to: <20050327181717.GC14502@kroah.com>
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <20050327183927.GA4535@nikolas.hn.org>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.8i
References: <20050327180431.GA4327@nikolas.hn.org>
 <20050327181717.GC14502@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 10:17:17AM -0800, Greg KH wrote:
> On Sun, Mar 27, 2005 at 01:04:31PM -0500, Nick Orlov wrote:
> > 
> >  - Whether the changes like the one above are "the right thing to do" ?
> 
> Yes.

Questionable.

> 
> >  - What's the best way to deal with this particular issue ?
> 
> Change the code to not use these functions.

In other words "forget about nvidia <-> udev interaction" ?
I do not think it is acceptable.

> Look at the vmware code for examples of how to do this.

Is there a place where I can download the code example without
registering / paying license fee ?

P.S. Please CC me, I'm not subscribed to the list.

-- 
With best wishes,
	Nick Orlov.

