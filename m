Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVC0S7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVC0S7L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVC0S7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:59:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33962 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261368AbVC0S7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:59:08 -0500
Date: Sun, 27 Mar 2005 13:59:03 -0500
From: Dave Jones <davej@redhat.com>
To: Chris Wright <chrisw@osdl.org>, Moritz Muehlenhoff <jmm@inutil.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.6
Message-ID: <20050327185902.GC708@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wright <chrisw@osdl.org>, Moritz Muehlenhoff <jmm@inutil.org>,
	linux-kernel@vger.kernel.org
References: <20050326033939.GV30522@shell0.pdx.osdl.net> <E1DF70M-0001ai-8z@localhost.localdomain> <20050326092753.GB30522@shell0.pdx.osdl.net> <20050327185259.GD5164@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327185259.GD5164@mythryan2.michonline.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 01:52:59PM -0500, Ryan Anderson wrote:
 > On Sat, Mar 26, 2005 at 01:27:53AM -0800, Chris Wright wrote:
 > > > Could you please add CAN IDs to the stable changelog for already assigned
 > > > vulnerabilities?
 > > 
 > > That's what I did for .5 -> .6.  We can't retroactively update changeset
 > > comments, and I'm not sure we have any other candidates in -stable.
 > > We'll certainly continue to add them as we have them.
 > 
 > bk helptool comments
 > 
 > You can, actually.

"Nota  bene:  if  the  deltas  being  commented have been committed to a
 changeset and have been pulled out  of  this  repository,  the  comment
 changes  will  not  propagate on the next bk pull.  It is strongly sug-
 gested that you use this only on  uncommitted  deltas  which  have  not
 been  pulled  or cloned.  In the future, we will add a way of enforcing this."

That would suggest otherwise.

		Dave

