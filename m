Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUHZKrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUHZKrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUHZKrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:47:48 -0400
Received: from mail.shareable.org ([81.29.64.88]:58053 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S268033AbUHZKrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:47:39 -0400
Date: Thu, 26 Aug 2004 11:47:13 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Paul Jackson <pj@sgi.com>
Cc: Helge Hafting <helge.hafting@hist.no>, riel@redhat.com,
       mikulas@artax.karlin.mff.cuni.cz, torvalds@osdl.org, hch@lst.de,
       reiser@namesys.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826104713.GA30449@mail.shareable.org>
References: <Pine.LNX.4.44.0408252052420.13240-100000@chimarrao.boston.redhat.com> <412D968B.9030107@hist.no> <20040826022137.1504ffb7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826022137.1504ffb7.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> I find the idea that most backup tools and scripts will silently
> stop working correctly to be pretty scary.  

Too late.  We have xattrs already; many programs don't store them.

-- Jamie
