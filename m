Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUHBVxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUHBVxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUHBVwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:52:54 -0400
Received: from matrix.gna.ch ([195.226.6.8]:60571 "EHLO matrix.gna.ch")
	by vger.kernel.org with ESMTP id S263972AbUHBVvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:51:39 -0400
Subject: Re: DRM code reorganization
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Dave Jones <davej@redhat.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Ian Romanick <idr@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
In-Reply-To: <20040802210935.GF12724@redhat.com>
References: <410E9FEE.60108@us.ibm.com>
	 <20040802204204.88994.qmail@web14926.mail.yahoo.com>
	 <20040802210935.GF12724@redhat.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Aug 2004 23:51:02 +0200
Message-Id: <1091483462.32409.162.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 22:09 +0100, Dave Jones wrote:
> 
> If subsequent DRI tree -> kernel merges back out any cleanup work, it's 
> definitly going to be a waste of time even trying.

That can easily be avoided by doing the cleanup the right way in the
first place, i.e. in the DRI tree...


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

