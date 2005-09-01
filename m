Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVIAPL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVIAPL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVIAPLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:11:55 -0400
Received: from gate.in-addr.de ([212.8.193.158]:53983 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1030191AbVIAPLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:11:54 -0400
Date: Thu, 1 Sep 2005 17:11:18 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, David Teigland <teigland@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050901151118.GV28276@marowsky-bree.de>
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901142708.GA24933@infradead.org> <1125588511.15768.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1125588511.15768.52.camel@localhost.localdomain>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-09-01T16:28:30, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Competition will decide if OCFS or GFS is better, or indeed if someone
> comes along with another contender that is better still. And competition
> will probably get the answer right.

Competition will come up with the same situation like reiserfs and ext3
and XFS, namely that they'll all be maintained going forward because of,
uhm, political constraints ;-)

But then, as long as they _are_ maintained and play along nicely with
eachother (which, btw, is needed already so that at least data can be
migrated...), I don't really see a problem of having two or three.

> The only thing that is important is we don't end up with each cluster fs
> wanting different core VFS interfaces added.

Indeed.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

