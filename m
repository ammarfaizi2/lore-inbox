Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVCNSC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVCNSC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVCNR7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:59:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:58031 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261652AbVCNRye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:54:34 -0500
Date: Mon, 14 Mar 2005 09:54:27 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: domen@coderock.org, ghoward@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 01/14] char/snsc: reorder set_current_state() and add_wait_queue()
Message-ID: <20050314175427.GA2993@us.ibm.com>
References: <20050306223616.C82751EC90@trashy.coderock.org> <200503140945.44323.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503140945.44323.jbarnes@engr.sgi.com>
X-Operating-System: Linux 2.6.11 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 09:45:44AM -0800, Jesse Barnes wrote:
> On Sunday, March 6, 2005 2:36 pm, domen@coderock.org wrote:
> > Any comments would be, as always, appreciated.
> 
> I don't have a problem with this change, but the maintainer probably should 
> have been Cc'd.  Greg, does this change look ok to you?  Note that it's 
> already been committed to the upstream tree, so if it's a bad change we'll 
> need to have the cset excluded or something.

Thanks for the feedback. I don't see a maintainer entry for Greg
anywhere in the snsc.{c,h} files or MAINTAINERS. Could someone throw a
patch upstream so that whomever should be contacted for this driver will
be in the future?

Thanks,
Nish
