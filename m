Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVAGPgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVAGPgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVAGPgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:36:36 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:64649 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261463AbVAGPfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:35:12 -0500
Date: Fri, 7 Jan 2005 07:34:48 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, gregkh@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107153447.GD1267@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <1105083213.4179.1.camel@laptopd505.fenrus.org> <20050107151223.GA1267@us.ibm.com> <1105111432.4179.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105111432.4179.31.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 04:23:52PM +0100, Arjan van de Ven wrote:
> 
> > > eh maybe a weird question, but why are you and not the MVFS guys asking
> > > for this export then? They can probably better explain why they need
> > > it ....
> > 
> > As near as I can tell, they believe that they already did the best they
> > could to explain their needs and failed to do so.
> > 
> 
> can you try to find even ONE request for these exports from them in the
> mailing list archives? Since I find that hard to believe.

I did not find much when I searched yesterday, which is why I had to ask
Al what advice he had given them.

							Thanx, Paul
