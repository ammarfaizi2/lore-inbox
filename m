Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424828AbWKQAzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424828AbWKQAzr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424829AbWKQAzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:55:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:58603 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1424828AbWKQAzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:55:46 -0500
Date: Thu, 16 Nov 2006 18:55:40 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, Alan Cox <alan@redhat.com>,
       "Ryan S. Arnold" <rsa@us.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: HVCS char driver janitoring: fix compile warnings
Message-ID: <20061117005540.GF23600@austin.ibm.com>
References: <20061115212619.GJ8395@austin.ibm.com> <1163635387.8805.7.camel@localhost.localdomain> <20061116203946.GA23600@austin.ibm.com> <1163716536.16815.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163716536.16815.5.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 09:35:36AM +1100, Michael Ellerman wrote:
> 
> Thanks, new patches look good.

Any clue who I should send these to? I think akpm took the earlier
one, I'm not clear if that means it will slosh into Linus' tree 
eventually.

--linas
