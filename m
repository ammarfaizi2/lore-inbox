Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbSJaETY>; Wed, 30 Oct 2002 23:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265176AbSJaETY>; Wed, 30 Oct 2002 23:19:24 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:60934 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265174AbSJaETY>; Wed, 30 Oct 2002 23:19:24 -0500
Date: Thu, 31 Oct 2002 04:25:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Finnegan <pat@purdueriots.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: What's left over.
Message-ID: <20021031042548.A23326@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Finnegan <pat@purdueriots.com>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.LNX.4.44.0210302302360.8463-100000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210302302360.8463-100000@ibm-ps850.purdueriots.com>; from pat@purdueriots.com on Wed, Oct 30, 2002 at 11:20:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 11:20:42PM -0500, Patrick Finnegan wrote:
> Specifically, the interoperation with IBM's JFS LVM and MS's LVM will be

JFS has no lvm, it just sits on any blockdevice.  The support for Windows
dynamic disks actually layers ontop of the MD driver..

