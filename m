Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264306AbTH1Vq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTH1Vq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:46:58 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:25610 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264306AbTH1Vq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:46:57 -0400
Date: Thu, 28 Aug 2003 22:46:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Bryan O'Sullivan" <bos@keyresearch.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] netplug, a daemon that handles network cables getting plugged in and out
Message-ID: <20030828224652.A13004@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bryan O'Sullivan <bos@keyresearch.com>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com>; from bos@keyresearch.com on Thu, Aug 28, 2003 at 02:21:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 02:21:52PM -0700, Bryan O'Sullivan wrote:
> Netplug is a daemon that responds to network cables being plugged in or
> out by bringing a network interface up or down.  This is extremely
> useful for DHCP-managed systems that move around a lot, such as laptops
> and systems in cluster environments.

What's the difference to / advantage over ifplugd?

