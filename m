Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbTIDQTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbTIDQTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:19:07 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:49093 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S265253AbTIDQSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:18:46 -0400
Date: Thu, 4 Sep 2003 17:17:35 +0100
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com.br, samel@mail.cz
Subject: Re: BK-kernel-tools/shortlog update
Message-ID: <20030904161735.GN32335@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org,
	marcelo.tosatti@cyclades.com.br, samel@mail.cz
References: <20030903233333.C8468854D0@merlin.emma.line.org> <20030904160511.GB3357@redhat.com> <20030904160911.GA6694@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904160911.GA6694@merlin.emma.line.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 06:09:11PM +0200, Matthias Andree wrote:

 > > On Thu, Sep 04, 2003 at 01:33:33AM +0200, Matthias Andree wrote:
 > >  >  'davej:codmonkey.org.uk' => 'Dave Jones',
 > > This one looks fishy.
 > Are you sure this hasn't ever been used by accident? Then I'll drop it.

Looks like Linus typoed it once, as that one went in via gnu patch..

ChangeSet@1.676, 2002-10-08 10:14:07-07:00, davej@codmonkey.org.uk
  [PATCH] Various drivers using longs instead of ulongs for flags.

 > >  >  'davej:suse.de' => 'Dave Jones',
 > > You can nuke this one, I won't be using it again.
 > >  >  'davej:tetrachloride.(none)' => 'Dave Jones',
 > > Ditto, this box is no more.
 > I'm reluctant to drop addresses.

Ok.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
