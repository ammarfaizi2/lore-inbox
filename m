Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTL1Two (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 14:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTL1Two
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 14:52:44 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:18441 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261967AbTL1Twn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 14:52:43 -0500
Date: Sun, 28 Dec 2003 19:52:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: 2.6.0-mm1
Message-ID: <20031228195242.A22431@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"viro@parcelfarce.linux.theplanet.co.uk" <viro@parcelfarce.linux.theplanet.co.uk>
References: <20031222211131.70a963fb.akpm@osdl.org> <20031228105807.A19546@infradead.org> <20031228114906.5e9decdc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031228114906.5e9decdc.akpm@osdl.org>; from akpm@osdl.org on Sun, Dec 28, 2003 at 11:49:06AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 11:49:06AM -0800, Andrew Morton wrote:
> Have you discussed this with him?  I was actually hoping to get those patches
> merged up soon.

A while ago he said he's gonna redo those parts that don't change the
API for 2.6 and will postpone the rest to 2.7.

