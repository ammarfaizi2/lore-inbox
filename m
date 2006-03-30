Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWC3KZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWC3KZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWC3KZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:25:33 -0500
Received: from canuck.infradead.org ([205.233.218.70]:11477 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751343AbWC3KZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:25:32 -0500
Subject: Re: [patch 3/8] use list_add_tail() instead of list_add()
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Karsten Keil <kkeil@suse.de>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Sridhar Samudrala <sri@us.ibm.com>
In-Reply-To: <20060330083041.GN9287@atrey.karlin.mff.cuni.cz>
References: <20060330081605.085383000@localhost.localdomain>
	 <20060330081730.068972000@localhost.localdomain>
	 <20060330083041.GN9287@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 11:25:19 +0100
Message-Id: <1143714320.5600.253.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 10:30 +0200, Jan Kara wrote:
> > CC: Karsten Keil <kkeil@suse.de>
> > CC: Jan Harkes <jaharkes@cs.cmu.edu>
> > CC: Jan Kara <jack@suse.cz>
> > CC: David Woodhouse <dwmw2@infradead.org>
> > CC: Sridhar Samudrala <sri@us.ibm.com>
> > Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
>   Acked-by: Jan Kara <jack@suse.cz>

<AOL/>

-- 
dwmw2

