Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263592AbUE1PmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUE1PmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbUE1PmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:42:12 -0400
Received: from colin2.muc.de ([193.149.48.15]:53765 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263592AbUE1PmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:42:03 -0400
Date: 28 May 2004 17:42:01 +0200
Date: Fri, 28 May 2004 17:42:01 +0200
From: Andi Kleen <ak@muc.de>
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
Message-ID: <20040528154201.GA52991@colin2.muc.de>
References: <20Oc4-HT-25@gated-at.bofh.it> <m3zn7su4lv.fsf@averell.firstfloor.org> <20040528125447.GB11265@redhat.com> <20040528132358.GA78847@colin2.muc.de> <20040528134600.GF7499@pazke> <20040528151930.GA39560@colin2.muc.de> <20040528152246.GD11265@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528152246.GD11265@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually it does.  The ASUS P4P800 entry is very broken.
> Andrey's patches inadvertantly fix it by doing away with the
> necessity for NO_MATCH entries.

Well, several thousand lines of changes for a trivial bug fix 
that could be done much simpler also doesn't seem like the right 
approach for bug fixing in a stable kernel.

We can only hope that 2.7 opens soon, so that all those
"I really need to clean up something NOW" people leave 2.6
alone,  so that it can finally mature and become stable.

-Andi
